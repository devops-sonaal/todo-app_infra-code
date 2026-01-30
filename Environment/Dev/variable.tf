variable "rgs" {
  type = map(object({
    name       = string
    location   = string
    managed_by = string
    tags       = map(string)
  }))
}

variable "vnet" {
  type = map(object({
    name                = string
    location            = string
    address_space       = optional(list(string))
    resource_group_name = string
    dns_servers         = optional(list(string))
    tags                = optional(map(string))
  }))
}

variable "bastion_host_map" {
  description = "Configuration map for Bastion hosts"
  type = map(object({
    bastionhost_name    = string
    location            = string
    resource_group_name = string
    ip_configuration = list(object({
      name           = string
      subnet_name    = string
      public_ip_name = string
    }))
  }))
}


variable "public_ips" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
  }))
}

variable "subnets" {
  description = "A map of subnets to create"
  type = map(object({
    resource_group_name  = string
    virtual_network_name = string
    name                 = string
    address_prefixes     = list(string)
    service_endpoints    = optional(list(string), [])
    delegation = optional(list(object({
      name = string
      service_delegation = object({
        name    = string
        actions = list(string)
      })
    })), [])
    private_endpoint_network_policies = optional(string)

  }))
}
variable "subnet_nsg_map" {
  description = "Mapping between subnets and NSGs"
  type = map(object({
    subnet_key = string
    nsg_key    = string
  }))
}


variable "nsgs" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    tags                = optional(map(string))

    security_rules = optional(list(object({
      name                       = string
      priority                   = number
      direction                  = string
      access                     = string
      protocol                   = string
      source_port_range          = optional(string)
      destination_port_range     = optional(string)
      destination_port_ranges    = optional(list(string))
      source_address_prefix      = optional(string)
      destination_address_prefix = optional(string)
    })), [])
  }))
  description = "A map of network security group configurations."
}


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
variable "kv_role" {
  type        = string
  description = "The User Principal Name (UPN) of the admin user to be assigned roles."
}

variable "display_name" {
  type = string
  description = "Display name for the service principal or user assigned to Key Vault roles."
}


variable "key_vault_fetch" {
  description = "Key Vault details to fetch"
  type = map(object({
    name                = string
    resource_group_name = string
  }))
}


variable "vm_admin_password" {
  description = "VM Admin Passwords"
  type = map(object({
    name  = string
    value = string
  }))

}

variable "vm_admin_user" {
  description = "VM Admin User credentials"
  type = map(object({
    name  = string
    value = string
  }))
}
variable "secret_to_vault_map" {
  description = "Mapping of secret key to target key vault"
  type        = map(string)
  default = {
    vm_password  = "dev_key_vault"
    vm_adminuser = "dev_key_vault"
  }
}

variable "vm_nic" {
  description = "Map of NIC configurations for each VM"
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    tags                = map(string)
    ip_configuration = list(object({
      name                          = string
      subnet_name                   = string
      public_ip_name                = optional(string)
      private_ip_address_allocation = optional(string, "Dynamic")
    }))
  }))
}


variable "virtual_machines" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    vm_size             = string
      os_disk = object({
      managed_disk_type = string
      disk_size_gb      = number
    })
    storage_image_reference = object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    })
    os_profile = object({
      computer_name = string
      script_name   = string

    })
    os_profile_linux_config = object({
      disable_password_authentication = bool
    })
  }))
}


variable "stg" {
  description = "Map of Storage Accounts to create"
  type = map(object({
    name                     = string
    resource_group_name      = string
    location                 = string
    account_tier             = string
    account_replication_type = string

    min_tls_version = optional(string)

    tags = optional(map(string), {})

  }))
}

variable "vm_map" {
  type = map(object({
    key_vault_name        = string
    admin_user_secret     = string
    admin_password_secret = string
  }))
}



# variable "admin_password" {
#     description = "Map of VM admin passwords"
#     type = map(object({
#       name = string

#     })) 
# }

variable "mssql_servers" {
  description = "A map of MSSQL server configurations."
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    version             = string
    minimum_tls_version = string
  }))
}

variable "mssql_databases" {
  description = "A map of MSSQL database configurations."
  type = map(object({
    name       = string
    server_key = string # <-- ADD THIS
  }))
}

variable "mssql_server_fetch" {
  description = "A map of MSSQL server fetch configurations."
  type = map(object({
    sql_server_name     = string
    resource_group_name = string
  }))
}






