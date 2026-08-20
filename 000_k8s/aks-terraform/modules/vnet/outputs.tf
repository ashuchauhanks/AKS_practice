output "vnet_id" {
  value       = azurerm_virtual_network.this.id
  description = "The ID of the Virtual Network"
}

output "vnet_name" {
  value       = azurerm_virtual_network.this.name
  description = "The Name of the Virtual Network"
}

output "subnets" {
  value = {
    for k, v in azurerm_subnet.this : k => {
      id               = v.id
      name             = v.name
      address_prefixes = v.address_prefixes
    }
  }
  description = "Map of created subnets and their details"
}
