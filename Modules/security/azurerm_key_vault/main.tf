resource "azurerm_key_vault" "org_key_vault" {
    for_each = var.key_vaults  
        name                        = each.value.name
        location                    = each.value.location
        resource_group_name         = each.value.resource_group_name
        enabled_for_disk_encryption = each.value.enabled_for_disk_encryption
        tenant_id                   = coalesce(each.value.tenant_id, data.azurerm_client_config.tenant.tenant_id)
        soft_delete_retention_days  = each.value.soft_delete_retention_days
        purge_protection_enabled    = each.value.purge_protection_enabled

        sku_name = each.value.sku_name

        # Enable public access (allows access over internet)
        public_network_access_enabled = each.value.public_network_access_enabled

        # Enable RBAC instead of Access Policies
        rbac_authorization_enabled = each.value.rbac_authorization_enabled

network_acls {
  bypass         = each.value.network_acls.bypass
  default_action = each.value.network_acls.default_action
}

}

output "key_vault_ids" {
  value = {for k, v in azurerm_key_vault.org_key_vault : k => v.id}
}



# data "azuread_user" "me" {
#   user_principal_name = var.admin_upn
#   }

resource "azurerm_role_assignment" "kv_role_assign" {
  for_each             = azurerm_key_vault.org_key_vault   # loops per key vault
  scope                = each.value.id                      # key vault ID
  role_definition_name = var.kv_role                        # variable
  principal_id = data.azuread_service_principal.sp.object_id

}



