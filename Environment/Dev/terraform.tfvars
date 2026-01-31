rgs = {
  rg01 = {
    name       = "dev_rg01"
    location   = "centralindia"
    managed_by = "Demo"
    tags = {
      Name = "demo"
      Team = "IT"
    }
  }
}
vnet = {
  vnet01 = {
    name                = "dev-vnet01"
    location            = "centralindia"
    resource_group_name = "dev_rg01"
    address_space       = ["10.0.0.0/16"]
    dns_servers         = null
    tags                = { environment = "dev" }
  }
}

public_ips = {
  bastion_pub_ip01 = {
    name                = "dev_bastion_public_ip01"
    location            = "centralindia"
    resource_group_name = "dev_rg01"
  }
}

bastion_host_map = {
  dev_bastion_host1 = {
    bastionhost_name    = "dev-bastion-host01"
    location            = "centralindia"
    resource_group_name = "dev_rg01"
    ip_configuration = [{
      name           = "bastion_ip_configuration_name"
      subnet_name    = "bastion"
      public_ip_name = "bastion_pub_ip01"
    }]
  }
}

subnets = {
  frontend = {
    name                              = "dev-subnet-frontend"
    resource_group_name               = "dev_rg01"
    virtual_network_name              = "dev-vnet01"
    address_prefixes                  = ["10.0.1.0/24"]
    service_endpoints                 = null
    private_endpoint_network_policies = null
    nsg_name                          = "nsg_frontend"

  }

  backend = {
    name                 = "dev-subnet-backend"
    resource_group_name  = "dev_rg01"
    virtual_network_name = "dev-vnet01"
    address_prefixes     = ["10.0.2.0/24"]
    delegation           = []
    nsg_name             = "nsg_backend"
  }

  bastion = {
    name                              = "AzureBastionSubnet"
    resource_group_name               = "dev_rg01"
    virtual_network_name              = "dev-vnet01"
    address_prefixes                  = ["10.0.3.0/27"]
    private_endpoint_network_policies = null
  }
}

key_vaults = {
  dev_key_vault = {
    name                          = "devorgkeyvault002"
    location                      = "centralindia"
    resource_group_name           = "dev_rg01"
    enabled_for_disk_encryption   = true
    soft_delete_retention_days    = 7
    purge_protection_enabled      = false
    public_network_access_enabled = true
    sku_name                      = "standard"
    rbac_authorization_enabled    = true
    network_acls = {
      bypass         = "AzureServices"
      default_action = "Allow"
    }
  }
}

#admin_upn = "sonaal.kalra@superusermandeepdevopsoutlo.onmicrosoft.com"
kv_role   = "Key Vault Administrator"

display_name = "serviceConnection"



vm_admin_password = {
  key_vault_secret_vm_password = {
    name  = "vm-admin-password"
    value = "P@ssw0rd1234!"

  }
}
vm_admin_user = {
  key_vault_secret_vm_adminuser = {
    name  = "vm-admin-username"
    value = "azureuser"

  }
}
key_vault_fetch = {
  dev_key_vault = {
    name                = "devorgkeyvault002"
    resource_group_name = "dev_rg01"
  }
}

secret_to_vault_map = {
  key_vault_secret_vm_password  = "dev_key_vault"
  key_vault_secret_vm_adminuser = "dev_key_vault"
}

nsgs = {
  nsg_frontend = {
    name                = "dev_frontend_nsg"
    location            = "centralindia"
    resource_group_name = "dev_rg01"

    security_rules = [
      {
        name                       = "Allow_HTTP"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_ranges    = ["80", "22"]
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    ]
  }

  nsg_backend = {
    name                = "dev_backend_nsg"
    location            = "centralindia"
    resource_group_name = "dev_rg01"

    security_rules = [
      {
        name                       = "Allow_SSH"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    ]
  }

  nsg_bastion = {
    name                = "dev_bastion_nsg"
    location            = "centralindia"
    resource_group_name = "dev_rg01"

    security_rules = [
      {
        name                       = "AllowHttpsInbound"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_address_prefix      = "Internet"
        source_port_range          = "*"
        destination_address_prefix = "*"
        destination_port_range     = "443"
      },
      {
        name                       = "AllowGatewayManagerInbound"
        priority                   = 110
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_address_prefix      = "GatewayManager"
        source_port_range          = "*"
        destination_address_prefix = "*"
        destination_port_range     = "443"
      },
      {
        name                       = "AllowAzureLoadBalancerInbound"
        priority                   = 120
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "*"
        source_address_prefix      = "AzureLoadBalancer"
        source_port_range          = "*"
        destination_address_prefix = "*"
        destination_port_range     = "*"
      },
      {
        name                       = "AllowBastionOutboundAzureCloud"
        priority                   = 130
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "*"
        source_address_prefix      = "*"
        destination_address_prefix = "AzureCloud"
        source_port_range          = "*"
        destination_port_range     = "443"
      },
      {
        name                       = "AllowBastionOutboundInternet"
        priority                   = 140
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "*"
        source_address_prefix      = "*"
        destination_address_prefix = "Internet"
        source_port_range          = "*"
        destination_port_range     = "80"
      },
      {
        name                       = "AllowBastionOutboundVnet"
        priority                   = 150
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "*"
        source_address_prefix      = "*"
        destination_address_prefix = "VirtualNetwork"
        source_port_range          = "*"
        destination_port_range     = "*"
      }
    ]
  }
}

# Mapping which NSG goes to which subnet
subnet_nsg_map = {
  frontend_assoc = {
    subnet_key = "frontend"
    nsg_key    = "nsg_frontend"
  }

  backend_assoc = {
    subnet_key = "backend"
    nsg_key    = "nsg_backend"
  }
  backend_assoc = {
    subnet_key = "bastion"
    nsg_key    = "nsg_bastion"
  }

}

virtual_machines = {
  frontend_vm01 = {
    name                = "dev-frontend-vm01"
    location            = "centralindia"
    resource_group_name = "dev_rg01"
    vm_size             = "Standard_B1s"
    os_disk = {
      managed_disk_type = "Standard_LRS"
      disk_size_gb      = 30
    }
    storage_image_reference = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "22_04-lts-gen2"
      version   = "latest"

    }
    os_profile = {
      computer_name = "frontend"
      script_name   = "install_nginx.sh"
    
    }
    os_profile_linux_config = {
      disable_password_authentication = false
    }

  }

  backend_vm01 = {
    name                = "dev-backend-vm01"
    location            = "centralindia"
    resource_group_name = "dev_rg01"
    vm_size             = "Standard_B1s"
    os_disk = {
      managed_disk_type = "Standard_LRS"
      disk_size_gb      = 30
    }
    storage_image_reference = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "22_04-lts-gen2"
      version   = "latest"

    }
    os_profile = {
      computer_name = "backend"
      script_name   = "install_backend.sh"   
    }
    os_profile_linux_config = {
      disable_password_authentication = false
    }
  }
}

vm_nic = {
  frontend_vm01 = {
    name                = "dev-frontend-nic"
    location            = "centralindia"
    resource_group_name = "dev_rg01"
    tags = {
      environment = "dev"
      tier        = "frontend"
    }
    ip_configuration = [{
      name                          = "frontend-ipconfig"
      subnet_name                   = "frontend"
      public_ip_name                = "frontend-public-ip"
      private_ip_address_allocation = "Dynamic"
    }]
  }

  backend_vm01 = {
    name                = "dev-backend-nic"
    location            = "centralindia"
    resource_group_name = "dev_rg01"
    tags                = { environment = "dev" }
    ip_configuration = [{
      name                          = "backend-ipconfig"
      subnet_name                   = "backend"
      public_ip_name                = null
      private_ip_address_allocation = "Dynamic"
    }]
  }
}

stg = {
  devstgaccount01 = {
    name                     = "devstgdhonduaccount001"
    resource_group_name      = "dev_rg01"
    location                 = "centralindia"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    min_tls_version          = "TLS1_2"
    tags = {
      environment = "dev"
      team        = "IT"
    }
  }
}

# Key Vault to VM mapping for admin credentials
#-----------------------------------------
# VM, SQL admin username/password secrets
# IMPORTANT: Keys must match VM & SQL names
# ------------------------------------------
vm_map = {
  backend_vm01 = {
    key_vault_name        = "dev_key_vault"
    admin_user_secret     = "vm-admin-username"
    admin_password_secret = "vm-admin-password"
  }

  frontend_vm01 = {
    key_vault_name        = "dev_key_vault"
    admin_user_secret     = "vm-admin-username"
    admin_password_secret = "vm-admin-password"
  }

  #  MUST MATCH MSSQL SERVER NAME KEY
  mssql_server01 = {
    key_vault_name        = "dev_key_vault"
    admin_user_secret     = "vm-admin-username"
    admin_password_secret = "vm-admin-password"
  }
}


mssql_servers = {
  mssql_server01 = {
    name                = "dev-mssql-server01"
    resource_group_name = "dev_rg01"
    location            = "centralindia"
    version             = "12.0"
    minimum_tls_version = "1.2"
  }
}

mssql_server_fetch = {
  mssql_server01 = {
    sql_server_name     = "dev-mssql-server01"
    resource_group_name = "dev_rg01"
  }
}

mssql_databases = {
  mssql_db01 = {
    name       = "dev_mssql_database01"
    server_key = "mssql_server01" # MUST MATCH
  }
}

