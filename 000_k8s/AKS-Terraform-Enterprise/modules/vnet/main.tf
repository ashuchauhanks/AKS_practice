resource "azurerm_virtual_network" "this" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.vnet_address_space

  dynamic "subnet" {
    for_each = var.subnets
    content {
      name             = subnet.key
      address_prefixes = [subnet.value.address_prefix]
    }
  }


  tags = var.tags
}

# Note: Accessing IDs of inline subnets is complex. 
# We return a map of constructed IDs to maintain compatibility with other modules.
output "subnet_ids" {
  value = {
    for s in azurerm_virtual_network.this.subnet : s.name => "${azurerm_virtual_network.this.id}/subnets/${s.name}"
  }
}
