resource "azurerm_virtual_network" "vnet" {
  for_each = var.vnet
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  address_space       = lookup(each.value, "address_space", [])
  dns_servers         = lookup(each.value, "dns_servers", [])
  tags = each.value.tags
}

