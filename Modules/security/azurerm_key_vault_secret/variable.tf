variable "key_vault_fetch" {
  description = "Key Vault details to fetch"
   type = map(object({
    name                = string
    resource_group_name = string}))
}

variable "vm_admin_password" {
  description = "VM Admin Passwords"
  type = map(object({
    name = string
    value = string
  })) 

}

variable "vm_admin_user" {
  description = "VM Admin User credentials"
  type = map(object({
    name = string
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

variable "key_vault_ids" {
  description = "Mapping of key vault names to their IDs"
  type = map(string)
}

# variable "name" {
#   type = string
# }
# variable "resource_group_name" {
#   type = string
# }

