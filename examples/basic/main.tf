provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg-connectivity-01" {
  name     = "rg-connectivity-01"
  location = "westeurope"
}

resource "azurerm_resource_group" "bastion" {
  name     = "rg-ManagementBastion-prd-01"
  location = "westeurope"
}

resource "azurerm_virtual_network" "example" {
  name                = "examplevnet"
  address_space       = ["192.168.33.0/24"]
  location            = azurerm_resource_group.rg-connectivity-01.location
  resource_group_name = azurerm_resource_group.rg-connectivity-01.name
  depends_on = [
    azurerm_resource_group.rg-connectivity-01
  ]
}

module "azureBastion" {
  source                      = "../../"
  location                    = "westeurope"
  state                       = "dev"
  rg_connectivity_name        = "rg-connectivity-01"
  rg_bastion_name             = azurerm_resource_group.bastion.name
  bastion_vnet_name           = azurerm_virtual_network.example.name
  bastion_subnet_address      = ["192.168.33.192/26"]
  bastion_nsg_name            = "Bastion_NSG"
  sku                         = "Standard"
  
  depends_on = [
    azurerm_resource_group.rg-connectivity-01,
    azurerm_resource_group.bastion,
    azurerm_virtual_network.example
  ]

}
