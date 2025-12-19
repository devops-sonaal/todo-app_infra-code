resource "azurerm_network_security_group" "nsg" {
  for_each = var.nsgs

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  tags                = lookup(each.value, "tags", {})


  dynamic "security_rule" {
  for_each = lookup(each.value, "security_rules", [])

  content {
    name                       = security_rule.value.name
    priority                   = security_rule.value.priority
    direction                  = security_rule.value.direction
    access                     = security_rule.value.access
    protocol                   = security_rule.value.protocol

    # FIXED DEFAULTS (Azure requires these)
    source_port_range          = try(security_rule.value.source_port_range, "*")
    destination_port_range     = try(security_rule.value.destination_port_range, null)
    destination_port_ranges    = try(security_rule.value.destination_port_ranges, null)

    source_address_prefix      = try(security_rule.value.source_address_prefix, "*")
    destination_address_prefix = try(security_rule.value.destination_address_prefix, "*")
  }
}
}

# NOTE: output map key names preserved from var keys (nsg_definitions map keys)
output "nsg_output_ids" {
  description = "Map of NSG keys -> NSG IDs"
  value = { for k, v in azurerm_network_security_group.nsg : k => v.id }
}


