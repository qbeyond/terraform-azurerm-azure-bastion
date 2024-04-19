provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "connectivity" {
  name     = "rg-Connectivity-01"
  location = "westeurope"
}

resource "azurerm_resource_group" "bastion" {
  name     = "rg-ManagementBastion-prd-01"
  location = "westeurope"
}

resource "azurerm_virtual_network" "example" {
  name                = "examplevnet"
  address_space       = ["192.168.33.0/24"]
  location            = azurerm_resource_group.connectivity.location
  resource_group_name = azurerm_resource_group.connectivity.name
}

module "azureBastion" {
  source                      = "../../"
  location                    = "westeurope"
  state                       = "dev"
  rg_connectivity_name        = azurerm_resource_group.connectivity.name
  rg_bastion_name             = azurerm_resource_group.bastion.name
  bastion_vnet_name           = azurerm_virtual_network.example.name
  bastion_subnet_address      = "192.168.33.192/26"
  sku                         = "Standard"
  # Following variables are optional
  ip_connect_enabled          = true
  scale_units                 = 2
  copy_paste_enabled          = true
  file_copy_enabled           = true
  tunneling_enabled           = false
  shareable_link_enabled      = false
  tags                        = {
    "env" = "PRD"
  }
}
