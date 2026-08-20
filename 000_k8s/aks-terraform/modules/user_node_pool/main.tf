resource "azurerm_kubernetes_cluster_node_pool" "this" {
  for_each = var.node_pools

  name                  = each.key
  kubernetes_cluster_id = var.kubernetes_cluster_id
  vm_size               = each.value.vm_size
  node_count            = each.value.node_count
  os_disk_size_gb       = each.value.os_disk_size_gb
  vnet_subnet_id        = coalesce(each.value.vnet_subnet_id, var.vnet_subnet_id)
  auto_scaling_enabled  = each.value.enable_auto_scaling
  min_count             = each.value.enable_auto_scaling ? each.value.min_count : null
  max_count             = each.value.enable_auto_scaling ? each.value.max_count : null
  priority              = each.value.priority
  eviction_policy       = each.value.priority == "Spot" ? coalesce(each.value.eviction_policy, "Deallocate") : null
  spot_max_price        = each.value.priority == "Spot" ? each.value.spot_max_price : null
  node_labels           = each.value.node_labels
  node_taints           = each.value.node_taints
  zones                 = length(each.value.zones) > 0 ? each.value.zones : null

  tags = merge(var.tags, {
    "NodePoolType"   = "Worker"
    "CustomPoolName" = each.key
  })

  lifecycle {
    ignore_changes = [
      node_count
    ]
  }
}
