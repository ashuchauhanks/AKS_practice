variable "environment" {
  type        = string
  description = "Environment name (e.g. dev, prod)"
  default     = "dev"

  validation {
    condition     = contains(["dev", "prod", "staging", "test"], var.environment)
    error_message = "Environment must be one of: dev, prod, staging, test."
  }
}

variable "location" {
  type        = string
  description = "Azure region (e.g. eastus, centralus, westeurope)"
  default     = "eastus"
}

variable "project_name" {
  type        = string
  description = "Project prefix for resource naming"
  default     = "k8s-demo"
}

variable "vnet_address_space" {
  type        = list(string)
  description = "Address space for Virtual Network"
  default     = ["10.10.0.0/16"]
}

variable "subnets" {
  type = map(object({
    address_prefixes                  = list(string)
    private_endpoint_network_policies = optional(string, "Enabled")
    service_endpoints                 = optional(list(string), [])
  }))
  description = "Subnets configuration map"
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
    zones                = optional(list(string), [])
    only_critical_addons = optional(bool, true)
  })
  description = "System node pool configuration"
}

variable "user_node_pools" {
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
  }))
  description = "Worker user node pools configuration"
  default     = {}
}

variable "tags" {
  type        = map(string)
  description = "Custom resource tags"
  default     = {}
}
