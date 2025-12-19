resource "azurerm_mssql_server" "mssql" {
  for_each                     = var.mssql_servers
  name                         = each.value.name
  resource_group_name          = each.value.resource_group_name
  location                     = each.value.location
  version                      = each.value.version
  administrator_login          = data.azurerm_key_vault_secret.vm_admin_user[each.key].value
  administrator_login_password = data.azurerm_key_vault_secret.vm_admin_password[each.key].value
  minimum_tls_version          = each.value.minimum_tls_version

}

