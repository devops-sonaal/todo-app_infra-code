terraform {
  required_version = ">= 1.1"
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.47.0"
    }
  }
}

provider "azurerm" {
    features {}
  subscription_id = "389233e1-4bee-42cd-8a3b-7817b82589fd"
}
