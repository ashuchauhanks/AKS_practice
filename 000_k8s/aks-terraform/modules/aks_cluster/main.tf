resource "azurerm_kubernetes_cluster" "this" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix
  kubernetes_version  = var.kubernetes_version

  oidc_issuer_enabled       = true
  workload_identity_enabled = true

  default_node_pool {
    name                         = var.system_node_pool.name
    node_count                   = var.system_node_pool.node_count
    vm_size                      = var.system_node_pool.vm_size
    os_disk_size_gb              = var.system_node_pool.os_disk_size_gb
    vnet_subnet_id               = coalesce(var.system_node_pool.vnet_subnet_id, var.vnet_subnet_id)
    auto_scaling_enabled         = var.system_node_pool.enable_auto_scaling
    min_count                    = var.system_node_pool.enable_auto_scaling ? var.system_node_pool.min_count : null
    max_count                    = var.system_node_pool.enable_auto_scaling ? var.system_node_pool.max_count : null
    only_critical_addons_enabled = var.system_node_pool.only_critical_addons
    zones                        = length(var.system_node_pool.zones) > 0 ? var.system_node_pool.zones : null

    tags = merge(var.tags, {
      "NodePoolType" = "System"
    })
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin      = "azure"
    network_plugin_mode = "overlay"
    network_policy      = "azure"
    pod_cidr            = "10.244.0.0/16"
  }

  dynamic "oms_agent" {
    for_each = var.log_analytics_workspace_id != null ? [1] : []
    content {
      log_analytics_workspace_id = var.log_analytics_workspace_id
    }
  }

  tags = var.tags

  lifecycle {
    ignore_changes = [
      default_node_pool[0].node_count
    ]
  }
}
