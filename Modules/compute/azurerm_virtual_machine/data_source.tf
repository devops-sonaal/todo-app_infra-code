# Data source to fetch the existing Key Vault
data "azurerm_key_vault" "key_vault_info" {
  for_each =   var.key_vault_fetch
  name                = each.value.name
  resource_group_name = each.value.resource_group_name

}

data "azurerm_key_vault_secret" "vm_admin_user" {
  for_each = var.vm_map
  name         = each.value.admin_user_secret
  key_vault_id = var.key_vaults_map[each.value.key_vault_name]
}

data "azurerm_key_vault_secret" "vm_admin_password" {
  for_each = var.vm_map
  name         = each.value.admin_password_secret
  key_vault_id = var.key_vaults_map[each.value.key_vault_name]
}