locals {
  common_tags = merge(
    var.tags,
    {
      ManagedBy = "Terraform"
      Project   = "EnterpriseAKS"
    }
  )
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                    = var.cluster_name
  location                = var.location
  resource_group_name     = var.resource_group_name
  dns_prefix              = var.dns_prefix
  kubernetes_version      = var.kubernetes_version
  sku_tier                = var.sku_tier
  private_cluster_enabled = var.private_cluster_enabled

  default_node_pool {
    name                = var.default_node_pool.name
    node_count          = var.default_node_pool.node_count
    vm_size             = var.default_node_pool.vm_size
    auto_scaling_enabled = var.default_node_pool.enable_auto_scaling
    min_count           = var.default_node_pool.min_count
    max_count           = var.default_node_pool.max_count
    type                = var.default_node_pool.type
    vnet_subnet_id      = var.default_node_pool.vnet_subnet_id
    node_labels         = var.default_node_pool.node_labels
  }

  identity {
    type = "SystemAssigned"
  }

  dynamic "network_profile" {
    for_each = var.network_profile != null ? [var.network_profile] : []
    content {
      network_plugin     = network_profile.value.network_plugin
      load_balancer_sku  = lookup(network_profile.value, "load_balancer_sku", "standard")
      network_policy     = lookup(network_profile.value, "network_policy", null)
      service_cidr       = lookup(network_profile.value, "service_cidr", null)
      dns_service_ip     = lookup(network_profile.value, "dns_service_ip", null)
      pod_cidr           = lookup(network_profile.value, "pod_cidr", null)
      outbound_type      = lookup(network_profile.value, "outbound_type", "loadBalancer")
    }
  }

  dynamic "oms_agent" {
    for_each = var.log_analytics_workspace_id != null ? [1] : []
    content {
      log_analytics_workspace_id = var.log_analytics_workspace_id
    }
  }

  tags = local.common_tags
}

resource "azurerm_kubernetes_cluster_node_pool" "additional" {
  for_each = var.additional_node_pools

  name                  = each.key
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  vm_size               = each.value.vm_size
  node_count            = each.value.node_count
  auto_scaling_enabled  = each.value.enable_auto_scaling
  min_count             = each.value.min_count
  max_count             = each.value.max_count
  os_type               = each.value.os_type
  vnet_subnet_id        = each.value.vnet_subnet_id
  node_labels           = each.value.node_labels

  tags = local.common_tags
}
