# Azure Bastion NSG
resource "azurerm_network_security_group" "bastion" {
  name                = "nsg-${replace(replace(var.bastion_subnet_address, ".", "-"), "/", "-")}-Management-Bastion"
  location            = var.location
  resource_group_name = azurerm_subnet.bastion.resource_group_name
  ### Rules # Mandatory Rules for Azure Bastion - DO NOT CHANGE!!!
  #### Inbound Rules #####
  #https://docs.microsoft.com/en-us/azure/bastion/bastion-nsg
  
  security_rule {
    name                        = "Allow_Internet_to_BastionSubnet_Port443_Inbound"
    priority                    = 120
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "443"
    source_address_prefix       = "Internet"
    destination_address_prefix  = "*"
  }
  security_rule {
    name                        = "Allow_GatewayManager_to_BastionSubnet_Port443_Inbound"
    priority                    = 130
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "443"
    source_address_prefix       = "GatewayManager"
    destination_address_prefix  = "*"
  }
  security_rule {
    name                        = "Allow_AzureLoadBalancer_to_BastionSubnet_Port443_Inbound"
    priority                    = 140
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "443"
    source_address_prefix       = "AzureLoadBalancer"
    destination_address_prefix  = "*"
  }

  security_rule {
    name                        = "Allow_VirtualNetwork_to_VirtualNetwork_BastionHostCommunication_Inbound"
    priority                    = 150
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "*"
    source_port_range           = "*"
    destination_port_ranges     = ["8080", "5701"]
    source_address_prefix       = "VirtualNetwork"
    destination_address_prefix  = "VirtualNetwork"
  }
  #### Outbound Rules #####
  security_rule {
    name                        = "Allow_BastionSubnet_to_VirtualNetwork_RDP_SSH_Outbound"
    priority                    = 2020
    direction                   = "Outbound"
    access                      = "Allow"
    protocol                    = "*"
    source_port_range           = "*"
    destination_port_ranges     = ["3389", "22"]
    source_address_prefix       = "*"
    destination_address_prefix  = "VirtualNetwork"
  }
  
  security_rule {
    name                        = "Allow_BastionSubnet_to_AzureCloud_Port443_Outbound"
    priority                    = 2030
    direction                   = "Outbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_ranges     = ["443"]
    source_address_prefix       = "*"
    destination_address_prefix  = "AzureCloud"
  }

  security_rule {
    name                        = "Allow_VirtualNetwork_to_VirtualNetwork_BastionHostCommunication_Outbound"
    priority                    = 2040
    direction                   = "Outbound"
    access                      = "Allow"
    protocol                    = "*"
    source_port_range           = "*"
    destination_port_ranges     = ["8080", "5071"]
    source_address_prefix       = "VirtualNetwork"
    destination_address_prefix  = "VirtualNetwork"
  }

  security_rule {
    name                        = "Allow_BastionSubnet_to_Internet_Port80_Outbound"
    priority                    = 2050
    direction                   = "Outbound"
    access                      = "Allow"
    protocol                    = "*"
    source_port_range           = "*"
    destination_port_ranges     = ["80"]
    source_address_prefix       = "*"
    destination_address_prefix  = "Internet"
  }
}