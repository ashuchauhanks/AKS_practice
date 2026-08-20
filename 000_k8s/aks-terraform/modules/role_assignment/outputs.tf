output "assignments" {
  value = {
    for k, v in azurerm_role_assignment.this : k => {
      id                   = v.id
      role_definition_name = v.role_definition_name
      principal_id         = v.principal_id
      scope                = v.scope
    }
  }
  description = "Map of created role assignments"
}
