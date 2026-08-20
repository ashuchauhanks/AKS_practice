variable "cluster_name" {
  type        = string
  description = "Name of the AKS Cluster"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name where AKS cluster will be created"
}

variable "location" {
  type        = string
  description = "Azure region location"
}

variable "dns_prefix" {
  type        = string
  description = "DNS prefix for AKS control plane"
}

variable "kubernetes_version" {
  type        = string
  description = "Kubernetes Version"
  default     = null
}

variable "system_node_pool" {
  type = object({
    name                 = string
    vm_size              = string
    node_count           = number
    enable_auto_scaling  = optional(bool, false)
    min_count            = optional(number, 1)
    max_count            = optional(number, 3)
    os_disk_size_gb      = optional(number, 30)
    vnet_subnet_id       = optional(string, null)
    only_critical_addons = optional(bool, true)
    zones                = optional(list(string), [])
  })
  description = "Configuration block for the System Node Pool (Master/Control-Plane Addons Pool)"
  default = {
    name       = "system"
    vm_size    = "Standard_D2s_v7"
    node_count = 1
  }
}

variable "log_analytics_workspace_id" {
  type        = string
  description = "Log Analytics Workspace ID for Container Insights"
  default     = null
}

variable "vnet_subnet_id" {
  type        = string
  description = "Default Subnet ID for AKS system nodes"
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "Tags map"
  default     = {}
}
