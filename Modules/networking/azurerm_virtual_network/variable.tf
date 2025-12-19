variable "vnet" {
  type = map(object({
    name                = string
    location            = string
    address_space       = optional(list(string))
    resource_group_name = string
    dns_servers         = optional(list(string))
    tags                = optional(map(string))
  }))
  description = "A map of virtual network configurations."
}


