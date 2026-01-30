variable "key_vaults" {
  type = map(object({
    name                          = string
    location                      = string
    resource_group_name           = string
    enabled_for_disk_encryption   = bool
    soft_delete_retention_days    = number
    purge_protection_enabled      = bool
    public_network_access_enabled = bool
    sku_name                      = string
    rbac_authorization_enabled    = bool
    tenant_id                     = optional(string)
    network_acls = object({
      bypass         = string
      default_action = string
    })
    
  }))
}

# variable "admin_upn" {
#   type        = string
#   description = "The User Principal Name (UPN) of the admin user to be assigned roles." 
  
# }
variable "display_name" {
  type        = string
  description = "The display name of the Azure AD application representing the service principal."
  
}
variable "kv_role" {
  type        = string
  description = "The User Principal Name (UPN) of the admin user to be assigned roles."
}



