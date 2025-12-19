resource "azurerm_network_interface" "vm_nic" {
  for_each = var.vm_nic

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  tags                = each.value.tags

  dynamic "ip_configuration" {
    for_each = each.value.ip_configuration
    content {
      name                          = ip_configuration.value.name
      subnet_id                     = lookup(var.subnet_ids, ip_configuration.value.subnet_name, null)
      public_ip_address_id          = try(lookup(var.public_ip_ids, ip_configuration.value.public_ip_name, null), null)
      private_ip_address_allocation = lookup(ip_configuration.value, "private_ip_address_allocation", "Dynamic")
    }
  }
}


resource "azurerm_virtual_machine" "vm" {
  for_each = var.virtual_machines

  name                  = each.value.name
  location              = each.value.location
  resource_group_name   = each.value.resource_group_name
  network_interface_ids = [azurerm_network_interface.vm_nic[each.key].id]
  vm_size               = each.value.vm_size
  

  storage_os_disk {
    name              = "${each.value.name}-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = each.value.os_disk.managed_disk_type
    disk_size_gb     = each.value.os_disk.disk_size_gb
  }

  storage_image_reference {
    publisher = each.value.storage_image_reference.publisher
    offer     = each.value.storage_image_reference.offer
    sku       = each.value.storage_image_reference.sku
    version   = each.value.storage_image_reference.version
  }

  os_profile {
    computer_name  = each.value.os_profile.computer_name
    admin_username = data.azurerm_key_vault_secret.vm_admin_user[each.key].value
    admin_password = data.azurerm_key_vault_secret.vm_admin_password[each.key].value 
    #custom_data          = base64encode(file(each.value.os_profile.script_name))
    
  }

  os_profile_linux_config {
    disable_password_authentication = each.value.os_profile_linux_config.disable_password_authentication
    

  }
}

output "nic_output-ids" {
  value = {for k, v in azurerm_network_interface.vm_nic : k => v.id
  #if v.name == "dev-frontend-nic"
  }
}