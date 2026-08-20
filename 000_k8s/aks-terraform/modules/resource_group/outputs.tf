output "name" {
  value       = azurerm_resource_group.this.name
  description = "The name of the created Resource Group"
}

output "id" {
  value       = azurerm_resource_group.this.id
  description = "The ID of the created Resource Group"
}

output "location" {
  value       = azurerm_resource_group.this.location
  description = "The Azure region of the Resource Group"
}
