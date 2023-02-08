provider "azurerm" {
  features {}
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-01"
  address_space       = ["0.0.0.0/24"]
  dns_servers         = ["0.0.0.0", "1.1.1.1"]
  location            = "West Europe"
  resource_group_name = "rg-local"

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_subnet" "AzureBastionSubnet" {
  name                 = "bn-vnet-01"
  resource_group_name  = "rg-local"
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["0.0.0.0/26"]
}

module "azureBastion" {
  source                      = "../../"
  location                    = "West Europe"
  state                       = "dev"
  rg_connectivity_name        = "rg-connectivity-01"
  rg_management_name          = "rg-management-01"
  subnet_data                 = 
  network_security_group_data = 
}
