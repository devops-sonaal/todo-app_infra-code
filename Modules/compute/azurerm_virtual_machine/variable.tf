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


variable "subnet_ids" {
  type        = map(string)
  description = "Map of subnet names to subnet IDs"
}
variable "public_ip_ids" {
  type        = map(string)
  description = "Map of public IP names to public IP IDs"
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
      # admin_username = string
      # admin_password = string
    })
    os_profile_linux_config = object({
      disable_password_authentication = bool
    })
  }))
}
variable "key_vault_fetch" {
  description = "Key Vault details to fetch"
  type = map(object({
    name = string
  resource_group_name = string }))
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

# variable "key_vault_ids" {
#     description = "ID of the Key Vault containing the secrets"
#     type        = string    

# }

variable "key_vaults_map" {
  description = "Mapping of key vault names to their IDs"
  type        = map(string)
}
