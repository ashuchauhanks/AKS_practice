variable "role_assignments" {
  type = map(object({
    scope                = string
    role_definition_name = string
    principal_id         = string
  }))
  description = "Map of role assignments to grant using for_each"
  default     = {}
}
