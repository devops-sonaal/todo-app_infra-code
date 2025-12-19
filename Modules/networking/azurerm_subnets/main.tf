resource "azurerm_subnet" "subnet" {
  for_each = var.subnets

  name                 = each.value.name
  resource_group_name  = each.value.resource_group_name
  virtual_network_name = each.value.virtual_network_name
  address_prefixes     = each.value.address_prefixes  
 
 

  
  # Optional fields handled safely
  service_endpoints = try(each.value.service_endpoints, null)
  private_endpoint_network_policies = try(each.value.private_endpoint_network_policies, null)

  # Delegation block (optional)
  dynamic "delegation" {
    for_each = try(each.value.delegation, [])
    content {
      name = delegation.value.name

      service_delegation {
        name    = delegation.value.service_delegation.name
        actions = delegation.value.service_delegation.actions
      }
    }
  }
}




