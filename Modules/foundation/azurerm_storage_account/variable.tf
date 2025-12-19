variable "stg" {
  description = "Map of Storage Accounts to create"
  type = map(object({
    name                     = string
    resource_group_name      = string
    location                 = string
    account_tier             = string
    account_replication_type = string

    min_tls_version                   = optional(string)
    
    tags = optional(map(string), {})

  }))
}


