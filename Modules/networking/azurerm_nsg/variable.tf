variable "nsgs" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    tags                = optional(map(string))

    security_rules = optional(list(object({
      name                        = string
      priority                    = number
      direction                   = string
      access                      = string
      protocol                    = string
      source_port_range           = optional(string)
      destination_port_range      = optional(string)
      destination_port_ranges     = optional(list(string))
      source_address_prefix       = optional(string)
      destination_address_prefix  = optional(string)
    })), [])
  }))
  description = "A map of network security group configurations."
}

