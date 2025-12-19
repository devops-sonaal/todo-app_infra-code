resource "azurerm_mssql_database" "mssql01" {
  for_each = var.mssql_databases    
  name      = each.value.name
  server_id = data.azurerm_mssql_server.mssql_server[each.value.server_key].id
}

data "azurerm_mssql_server" "mssql_server" {
  for_each = var.mssql_server_fetch
  name                = each.value.sql_server_name
  resource_group_name = each.value.resource_group_name
}
