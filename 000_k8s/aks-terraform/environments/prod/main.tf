data "azurerm_subscription" "current" {}

data "azurerm_client_config" "current" {}

# Module 1: Resource Group Creation
module "resource_group" {
  source   = "../../modules/resource_group"
  name     = local.resource_group_name
  location = var.location
  tags     = local.common_tags
}

# DATA BLOCK: Fetch Resource Group details after creation
data "azurerm_resource_group" "this" {
  name       = local.resource_group_name
  depends_on = [module.resource_group]
}

# Module 2: Virtual Network & Subnets Creation
module "vnet" {
  source              = "../../modules/vnet"
  vnet_name           = local.vnet_name
  resource_group_name = data.azurerm_resource_group.this.name
  location            = data.azurerm_resource_group.this.location
  address_space       = var.vnet_address_space
  subnets             = var.subnets
  tags                = local.common_tags
}

# DATA BLOCK: Fetch Virtual Network details
data "azurerm_virtual_network" "this" {
  name                = local.vnet_name
  resource_group_name = data.azurerm_resource_group.this.name
  depends_on          = [module.vnet]
}

# DATA BLOCK: Fetch AKS Subnet details
data "azurerm_subnet" "aks" {
  name                 = "aks-subnet"
  virtual_network_name = data.azurerm_virtual_network.this.name
  resource_group_name  = data.azurerm_resource_group.this.name
  depends_on           = [module.vnet]
}

# Module 3: Log Analytics Workspace Creation
module "log_analytics" {
  source              = "../../modules/log_analytics"
  workspace_name      = local.log_analytics_name
  resource_group_name = data.azurerm_resource_group.this.name
  location            = data.azurerm_resource_group.this.location
  sku                 = "PerGB2018"
  retention_in_days   = 60
  tags                = local.common_tags
}

# DATA BLOCK: Fetch Log Analytics Workspace details
data "azurerm_log_analytics_workspace" "this" {
  name                = local.log_analytics_name
  resource_group_name = data.azurerm_resource_group.this.name
  depends_on          = [module.log_analytics]
}

# Module 4: AKS Cluster Creation
module "aks" {
  source                     = "../../modules/aks_cluster"
  cluster_name               = local.aks_cluster_name
  resource_group_name        = data.azurerm_resource_group.this.name
  location                   = data.azurerm_resource_group.this.location
  dns_prefix                 = local.aks_dns_prefix
  system_node_pool           = var.system_node_pool
  vnet_subnet_id             = data.azurerm_subnet.aks.id
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.this.id
  tags                       = local.common_tags
}

# DATA BLOCK: Fetch AKS Cluster details
data "azurerm_kubernetes_cluster" "this" {
  name                = local.aks_cluster_name
  resource_group_name = data.azurerm_resource_group.this.name
  depends_on          = [module.aks]
}

# Module 5: User Node Pools Creation
module "user_node_pools" {
  source                = "../../modules/user_node_pool"
  kubernetes_cluster_id = data.azurerm_kubernetes_cluster.this.id
  vnet_subnet_id        = data.azurerm_subnet.aks.id
  node_pools            = var.user_node_pools
  tags                  = local.common_tags
}

# Module 6: RBAC Role Assignments (Using Data Block references)
module "role_assignments" {
  source = "../../modules/role_assignment"

  role_assignments = {
    "network_contributor_aks_subnet" = {
      scope                = data.azurerm_subnet.aks.id
      role_definition_name = "Network Contributor"
      principal_id         = data.azurerm_kubernetes_cluster.this.identity[0].principal_id
    }
  }
}
