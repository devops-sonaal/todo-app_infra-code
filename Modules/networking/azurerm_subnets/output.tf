output "subnet_output_ids" {
  description = "Map of subnet names to their IDs"
  value       = { for k, v in azurerm_subnet.subnet : k => v.id }
}


# output "bastion_subnet_ids" {
#   description = "Azure Bastion subnet IDs"
#   value = {
#     for k, v in azurerm_subnet.subnet :
#     k => v.id if v.name == "AzureBastionSubnet"
#   }
# }

# output "subnet_ids" {
#   description = "Subnet IDs"
#   value = {
#     for k, v in azurerm_subnet.subnet :
#     k => v.id if v.name == "dev_subnet-frontend"
#   }
# }

# output "subnet_output_ids" {
#   description = "Map of subnet names to their IDs"
#   value       = { for k, v in azurerm_subnet.subnet : k => v.id }
# }

