resource "azurerm_bastion_host" "bastion_host" {
  for_each = var.bastion_host_map

  name                = each.value.bastionhost_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  dynamic "ip_configuration" {
    for_each = each.value.ip_configuration
    content {
      name                 = ip_configuration.value.name
      subnet_id            = lookup(var.bastion_subnet_map, ip_configuration.value.subnet_name, null)
      public_ip_address_id = lookup(var.bastion_public_ip_map, ip_configuration.value.public_ip_name, null)
    }
  }
}
