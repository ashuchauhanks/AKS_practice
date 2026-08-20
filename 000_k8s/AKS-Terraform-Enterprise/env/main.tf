terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}

locals {
  region_mapping = {
    "eastus"         = "eus"
    "eastus2"        = "eus2"
    "westus"         = "wus"
    "northcentralus" = "ncus"
    "southcentralus" = "scus"
    "centralus"      = "cus"
  }

  region_short = lookup(local.region_mapping, lower(replace(var.location, " ", "")), "global")
  name_prefix  = "${var.app_name}-${var.env_name}-${local.region_short}"

  common_tags = merge(var.tags, {
    Environment = var.env_name
    Application = var.app_name
  })
}

module "resource_group" {
  source   = "../modules/resource_group"
  rg_name  = "rg-${local.name_prefix}"
  location = var.location
  tags     = local.common_tags
}

module "network" {
  source              = "../modules/vnet"
  vnet_name           = "vnet-${local.name_prefix}"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  vnet_address_space  = var.vnet_address_space
  subnets = {
    "snet-${local.name_prefix}" = {
      address_prefix = var.subnet_address_prefix[0]
    }
  }
  tags = local.common_tags
}

module "monitoring" {
  source              = "../modules/log_analytics"
  law_name            = "law-${local.name_prefix}"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  tags                = local.common_tags
}

module "aks_cluster" {
  source = "../modules/aks"

  cluster_name        = "aks-${local.name_prefix}"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  dns_prefix          = var.dns_prefix
  kubernetes_version  = var.kubernetes_version
  sku_tier            = var.sku_tier

  default_node_pool = merge(var.default_node_pool, {
    vnet_subnet_id = module.network.subnet_ids["snet-${local.name_prefix}"]
  })

  additional_node_pools = {
    for k, v in var.additional_node_pools : k => merge(v, {
      vnet_subnet_id = module.network.subnet_ids["snet-${local.name_prefix}"]
    })
  }

  network_profile            = var.network_profile
  log_analytics_workspace_id = module.monitoring.id
  tags                       = local.common_tags
}
