variable "kubernetes_cluster_id" {
  type        = string
  description = "Target AKS Cluster ID"
}

variable "vnet_subnet_id" {
  type        = string
  description = "Default Subnet ID for the user node pools"
  default     = null
}

variable "node_pools" {
  type = map(object({
    vm_size             = string
    node_count          = number
    os_disk_size_gb     = optional(number, 30)
    enable_auto_scaling = optional(bool, false)
    min_count           = optional(number, 1)
    max_count           = optional(number, 3)
    priority            = optional(string, "Regular")
    eviction_policy     = optional(string, null)
    spot_max_price      = optional(number, -1)
    node_labels         = optional(map(string), {})
    node_taints         = optional(list(string), [])
    zones               = optional(list(string), [])
    vnet_subnet_id      = optional(string, null)
  }))
  description = "Map of user node pool configurations to create using for_each"
  default     = {}
}

variable "tags" {
  type        = map(string)
  description = "Tags map"
  default     = {}
}
