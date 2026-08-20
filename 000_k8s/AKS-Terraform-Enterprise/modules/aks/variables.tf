variable "cluster_name" {
  type        = string
  description = "Name of the AKS cluster"
}

variable "location" {
  type        = string
  description = "Azure region where the resources will be created"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the existing resource group"
}

variable "dns_prefix" {
  type        = string
  description = "DNS prefix for the cluster"
}

variable "kubernetes_version" {
  type        = string
  description = "Kubernetes version for the cluster"
  default     = "1.28"
}

variable "sku_tier" {
  type        = string
  description = "The SKU Tier that should be used for this Kubernetes Cluster. Possible values are Free, Standard and Premium."
  default     = "Free"
}

variable "private_cluster_enabled" {
  type        = bool
  description = "Should this Kubernetes Cluster have its API server only exposed on internal IP addresses?"
  default     = false
}

variable "default_node_pool" {
  type = object({
    name                = string
    node_count          = number
    vm_size             = string
    enable_auto_scaling = optional(bool, false)
    min_count           = optional(number, null)
    max_count           = optional(number, null)
    type                = optional(string, "VirtualMachineScaleSets")
    vnet_subnet_id      = optional(string, null)
    node_labels         = optional(map(string), {})
  })
  description = "Configuration for the default node pool"
}

variable "additional_node_pools" {
  type = map(object({
    node_count          = number
    vm_size             = string
    enable_auto_scaling = optional(bool, false)
    min_count           = optional(number, null)
    max_count           = optional(number, null)
    os_type             = optional(string, "Linux")
    vnet_subnet_id      = optional(string, null)
    node_labels         = optional(map(string), {})
  }))
  description = "Map of additional node pools to create"
  default     = {}
}

variable "network_profile" {
  type = object({
    network_plugin    = string
    load_balancer_sku = optional(string, "standard")
    network_policy    = optional(string, null)
    service_cidr      = optional(string, null)
    dns_service_ip    = optional(string, null)
    pod_cidr          = optional(string, null)
    outbound_type     = optional(string, "loadBalancer")
  })
  description = "Network profile configuration"
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource"
  default     = {}
}

variable "log_analytics_workspace_id" {
  type        = string
  description = "ID of the Log Analytics Workspace for monitoring"
  default     = null
}
