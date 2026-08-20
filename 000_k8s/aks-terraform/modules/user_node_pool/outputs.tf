output "node_pools" {
  value = {
    for k, v in azurerm_kubernetes_cluster_node_pool.this : k => {
      id         = v.id
      name       = v.name
      vm_size    = v.vm_size
      node_count = v.node_count
    }
  }
  description = "Map of created user node pools and details"
}
