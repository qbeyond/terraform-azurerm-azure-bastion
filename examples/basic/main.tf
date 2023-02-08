provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}

resource "azurerm_network_security_group" "example" {
  name                = "acceptanceTestSecurityGroup1"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  security_rule {
    name                       = "test123"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = "Production"
  }
}

resource "azurerm_subnet" "example" {
  name                 = "bn-vnet-01"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["0.0.0.0/26"]
}

module "azureBastion" {
  source                      = "../../"
  location                    = "West Europe"
  state                       = "dev"
  rg_connectivity_name        = "rg-connectivity-01"
  rg_management_name          = "rg-management-01"
  subnet_data                 = azurerm_subnet.example
  network_security_group_data = azurerm_network_security_group.example
}
