terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.47.0"
    }
  }
}

provider "azurerm" {
    features {}
  subscription_id = "f5462578-ed0d-4878-93ea-2462f9a3dac4"
}