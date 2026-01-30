data "azuread_application" "service_principle" {
  display_name = var.display_name
}

data "azurerm_client_config" "tenant" {}

# Get Service Principal using Application ID
data "azuread_service_principal" "sp" {
  client_id = data.azuread_application.service_principle.client_id
}

