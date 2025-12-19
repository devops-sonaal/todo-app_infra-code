variable "bastion_host_map" {
  description = "Configuration map for Bastion hosts"
  type = map(object({
    bastionhost_name    = string
    location            = string
    resource_group_name = string
    ip_configuration = list(object({
      name            = string
      subnet_name     = string
      public_ip_name  = string
    }))
  }))
}





variable "bastion_subnet_map" {
  description = "Map of Bastion host keys to subnet IDs"
  type        = map(string)
}

variable "bastion_public_ip_map" {
  description = "Map of Bastion host keys to public IP IDs"
  type        = map(string)
}

variable "key_vaults" {
  description = "Mapping of key vault names to their IDs"
  type = map(string)
}
