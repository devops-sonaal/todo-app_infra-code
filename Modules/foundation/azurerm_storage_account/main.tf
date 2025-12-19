resource "azurerm_storage_account" "child_module_stg" {
  for_each                          = var.stg
  name                              = each.value.name
  resource_group_name               = each.value.resource_group_name
  location                          = each.value.location
  account_tier                      = each.value.account_tier
  account_replication_type          = each.value.account_replication_type
  min_tls_version                   = each.value.min_tls_version
  tags = each.value.tags

 
}
  


