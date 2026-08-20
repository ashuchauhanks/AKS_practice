variable "env_name" {
  type        = string
  description = "Environment name (e.g. dev, prod)"
}

variable "app_name" {
  type        = string
  description = "Application name used for resource naming"
  default     = "entaks"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "dns_prefix" {
  type        = string
  description = "DNS prefix for the cluster"
}

variable "kubernetes_version" {
  type        = string
  description = "Kubernetes version"
  default     = "1.28"
}

variable "sku_tier" {
  type        = string
  description = "SKU tier"
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
    node_labels         = optional(map(string), {})
  })
  description = "Default node pool configuration"
}

variable "additional_node_pools" {
  type = map(object({
    node_count          = number
    vm_size             = string
    enable_auto_scaling = optional(bool, false)
    min_count           = optional(number, null)
    max_count           = optional(number, null)
    os_type             = optional(string, "Linux")
    node_labels         = optional(map(string), {})
  }))
  description = "Additional node pools"
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
  description = "Network profile"
  default     = null
}

variable "vnet_address_space" {
  type    = list(string)
  default = ["10.0.0.0/16"]
}

variable "subnet_address_prefix" {
  type    = list(string)
  default = ["10.0.1.0/24"]
}

variable "tags" {
  type    = map(string)
  default = {}
}
