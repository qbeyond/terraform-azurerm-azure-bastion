terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = var.azurerm_version
    }
  }
}
