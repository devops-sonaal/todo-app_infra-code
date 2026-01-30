module "dev_rg" {
  source = "../../Modules/foundation/azurerm_resource_group"
  rgs    = var.rgs

}
module "dev_stg" {
  depends_on = [module.dev_rg]
  source     = "../../Modules/foundation/azurerm_storage_account"
  stg        = var.stg

}

module "dev_vnet" {
  depends_on = [module.dev_rg]
  source     = "../../Modules/networking/azurerm_virtual_network"
  vnet       = var.vnet



}

module "dev_bastion" {
  source                = "../../Modules/networking/azurerm_bastion"
  bastion_host_map      = var.bastion_host_map
  bastion_subnet_map    = module.dev_subnet.subnet_output_ids
  bastion_public_ip_map = module.dev_public_ip.public_ip_output_ids
  depends_on            = [module.dev_rg, module.dev_subnet, module.dev_public_ip]
  key_vaults            = module.Key_vault_dev.key_vault_ids

}


module "dev_public_ip" {
  source     = "../../Modules/networking/azurerm_public_IPs"
  depends_on = [module.dev_rg]
  public_ips = var.public_ips

}

module "dev_subnet" {
  source     = "../../Modules/networking/azurerm_subnets"
  subnets    = var.subnets
  depends_on = [module.dev_vnet, module.dev_rg]


}
module "dev_nsg" {
  source     = "../../Modules/networking/azurerm_nsg"
  nsgs       = var.nsgs
  depends_on = [module.dev_subnet, module.dev_rg]

}

# NSG–Subnet Association
resource "azurerm_subnet_network_security_group_association" "assoc" {
  for_each                  = var.subnet_nsg_map
  subnet_id                 = module.dev_subnet.subnet_output_ids[each.value.subnet_key]
  network_security_group_id = module.dev_nsg.nsg_output_ids[each.value.nsg_key]
}


module "Key_vault_dev" {
  source     = "../../Modules/security/azurerm_key_vault"
  key_vaults = var.key_vaults
  depends_on = [module.dev_rg]
  kv_role    = var.kv_role
  #admin_upn  = var.admin_upn
  display_name = var.display_name


}

module "key_vaults_secret" {
  source              = "../../Modules/security/azurerm_key_vault_secret"
  key_vault_ids       = module.Key_vault_dev.key_vault_ids
  vm_admin_password   = var.vm_admin_password
  vm_admin_user       = var.vm_admin_user
  secret_to_vault_map = var.secret_to_vault_map
  depends_on          = [module.Key_vault_dev]
  key_vault_fetch     = var.key_vault_fetch

}


module "dev_vm" {
  source           = "../../Modules/compute/azurerm_virtual_machine"
  vm_nic           = var.vm_nic
  subnet_ids       = module.dev_subnet.subnet_output_ids
  public_ip_ids    = module.dev_public_ip.public_ip_output_ids
  virtual_machines = var.virtual_machines
  depends_on       = [module.dev_nsg, module.key_vaults_secret]
  key_vault_fetch  = var.key_vault_fetch
  vm_map           = var.vm_map
  key_vaults_map   = module.Key_vault_dev.key_vault_ids

}

module "dev_mssql_servers" {
  source          = "../../Modules/compute/azurerm_mssql_server"
  mssql_servers   = var.mssql_servers
  depends_on      = [module.key_vaults_secret, module.dev_rg]
  key_vault_fetch = var.key_vault_fetch
  vm_map          = var.vm_map
  key_vaults_map  = module.Key_vault_dev.key_vault_ids
  
}

module "dev_mssql_databases" {
source           = "../../Modules/compute/azurerm_mssql_database"
mssql_databases = var.mssql_databases
mssql_server_fetch = var.mssql_server_fetch
depends_on      = [module.dev_mssql_servers]
  
}




