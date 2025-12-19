# Public IP
resource "azurerm_public_ip" "public_ip" {
  for_each            = var.public_ips
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

output "public_ip_output_ids" {
  description = "Public IP IDs for Bastion"
  value = {
    for k, v in azurerm_public_ip.public_ip : k => v.id
  }
}
# Note: The variable "bastion_pub_ip" should be defined in variable.tf



