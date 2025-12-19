  variable "mssql_servers" {
    description = "A map of MSSQL server configurations."
    type = map(object({
      name                 = string
      resource_group_name  = string
      location             = string
      version              = string
      minimum_tls_version  = string
    }))
  }

  variable "key_vault_fetch" {
    description = "Key Vault details to fetch"
    type = map(object({
      name                = string
      resource_group_name = string
      }))
    
  }

  variable "vm_map" {
    description = "Map of MSSQL server admin credentials stored in Key Vault"
    type = map(object({
      key_vault_name        = string
      admin_user_secret     = string
      admin_password_secret = string
    })) 
  }

  variable "key_vaults_map" {
    description = "Map of Key Vault names to Key Vault IDs"
    type = map(string)
  }