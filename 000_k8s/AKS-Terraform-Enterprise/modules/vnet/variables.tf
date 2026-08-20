variable "vnet_name" {
  type        = string
  description = "The name of the virtual network"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group"
}

variable "location" {
  type        = string
  description = "The Azure region"
}

variable "vnet_address_space" {
  type        = list(string)
  description = "The address space for the VNet"
}

variable "subnets" {
  type = map(object({
    address_prefix = string
  }))
  description = "A map of subnets to create inline within the VNet"
}

variable "tags" {
  type    = map(string)
  default = {}
}
