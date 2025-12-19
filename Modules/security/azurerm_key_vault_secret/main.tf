# Data source to fetch the existing Key Vault
data "azurerm_key_vault" "key_vault_info" {
  for_each =   var.key_vault_fetch
  name                = each.value.name
  resource_group_name = each.value.resource_group_name

}

# Create a key in the existing Key Vault
resource "azurerm_key_vault_secret" "secrets" {
    for_each        = var.vm_admin_password
    name            = each.value.name    # Name in Key Vault
    value           = each.value.value   # Secret value from variable
    key_vault_id    = var.key_vault_ids[var.secret_to_vault_map[each.key]]
}

resource "azurerm_key_vault_secret" "vm_adminuser" {
    for_each        = var.vm_admin_user
    name            = each.value.name    # Name in Key Vault
    value           = each.value.value   # Secret value from variable
    key_vault_id    =  var.key_vault_ids[var.secret_to_vault_map[each.key]]
}

# resource "azurerm_key_vault_secret" "db_connection" {
#     for_each      = var.db_connection_string
#     name         = each.value.name
#     value        = each.value.value
#     key_vault_id = azurerm_key_vault.org_key_vault[each.key].id
# }
