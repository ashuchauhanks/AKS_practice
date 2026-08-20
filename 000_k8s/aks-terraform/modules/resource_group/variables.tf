variable "name" {
  type        = string
  description = "Name of the Azure Resource Group"

  validation {
    condition     = length(var.name) > 0
    error_message = "Resource group name cannot be empty."
  }
}

variable "location" {
  type        = string
  description = "Azure region where the resource group will be created"
  default     = "eastus"
}

variable "tags" {
  type        = map(string)
  description = "Map of tags to assign to the resource group"
  default     = {}
}
