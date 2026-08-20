variable "vnet_name" {
  type        = string
  description = "Name of the Virtual Network"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  description = "Azure region for the VNet"
}

variable "address_space" {
  type        = list(string)
  description = "Address space for the Virtual Network"
  default     = ["10.0.0.0/16"]
}

variable "subnets" {
  type = map(object({
    address_prefixes                  = list(string)
    private_endpoint_network_policies = optional(string, "Enabled")
    service_endpoints                 = optional(list(string), [])
  }))
  description = "Map of subnets to create using for_each"
  default     = {}
}

variable "tags" {
  type        = map(string)
  description = "Tags for the network resources"
  default     = {}
}
