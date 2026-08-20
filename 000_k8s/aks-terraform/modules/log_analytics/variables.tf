variable "workspace_name" {
  type        = string
  description = "Name of the Log Analytics Workspace"
}

variable "resource_group_name" {
  type        = string
  description = "Resource Group Name"
}

variable "location" {
  type        = string
  description = "Azure Location"
}

variable "sku" {
  type        = string
  description = "SKU of the Log Analytics Workspace"
  default     = "PerGB2018"
}

variable "retention_in_days" {
  type        = number
  description = "Log retention in days"
  default     = 30
}

variable "tags" {
  type        = map(string)
  description = "Tags map"
  default     = {}
}
