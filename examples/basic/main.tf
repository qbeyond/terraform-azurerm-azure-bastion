provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg-connectivity-01" {
  name     = "rg-connectivity-01"
  location = "westeurope"
}

resource "azurerm_resource_group" "rg-management-01" {
  name     = "rg-management-01"
  location = "westeurope"
}

resource "azurerm_resource_group" "bastion" {
  name     = "rg-ManagementBastion-prd-01"
  location = "westeurope"

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_virtual_network" "example" {
  name                = "examplevnet"
  address_space       = ["192.168.33.0/24"]
  location            = azurerm_resource_group.rg-connectivity-01.location
  resource_group_name = azurerm_resource_group.rg-connectivity-01.name
}

resource "azurerm_subnet" "example" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.rg-connectivity-01.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["192.168.33.192/26"]
}

resource "azurerm_network_security_group" "example" {
  name                = "acceptanceTestSecurityGroup1"
  location            = azurerm_resource_group.rg-connectivity-01.location
  resource_group_name = azurerm_resource_group.rg-connectivity-01.name
  tags = {
    environment = "dev"
  }
}

module "azureBastion" {
  source                      = "../../"
  location                    = "westeurope"
  state                       = "dev"
  rg_connectivity_name        = "rg-connectivity-01"
  rg_management_name          = azurerm_resource_group.bastion.name
  subnet_data                 = azurerm_subnet.example
  network_security_group_data = azurerm_network_security_group.example
  sku                         = "Standard"
}
