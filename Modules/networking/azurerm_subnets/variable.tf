variable "subnets" {
  description = "A map of subnets to create"
  type = map(object({
    resource_group_name  = string
    virtual_network_name = string
    name        = string
    address_prefixes     = list(string)
    service_endpoints    = optional(list(string), [])
    delegation = optional(list(object({
      name = string
      service_delegation = object({
        name    = string
        actions = list(string)
      })
    })), [])
    private_endpoint_network_policies    = optional(string)
    private_link_service_network_policies = optional(string)
    
  }))

}


