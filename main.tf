resource "azurerm_bastion_host" "landing_zone_bastion_service" {
  name                = "bn-${var.subnet_data.virtual_network_name}"
  location            = var.location
  resource_group_name = var.rg_management_name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = var.subnet_data.id
    public_ip_address_id = azurerm_public_ip.landing_zone_vnet_pip_bastion.id
  }
}

resource "azurerm_public_ip" "landing_zone_vnet_pip_bastion" {
  name                = "pip-${var.state}-LandingZoneBastion-01-${var.location}"
  resource_group_name = var.rg_connectivity_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

### Associate 
# NSG association not possible for GatewaySubnet
#
resource "azurerm_subnet_network_security_group_association" "landing_zone_nsg_association_bastion" {
  depends_on = [azurerm_network_security_rule.landing_zone_nsg_rule_bastion_0001,
    azurerm_network_security_rule.landing_zone_nsg_rule_bastion_0002,
    azurerm_network_security_rule.landing_zone_nsg_rule_bastion_0003,
    azurerm_network_security_rule.landing_zone_nsg_rule_bastion_0004,
    azurerm_network_security_rule.landing_zone_nsg_rule_bastion_2000,
    azurerm_network_security_rule.landing_zone_nsg_rule_bastion_2001,
    azurerm_network_security_rule.landing_zone_nsg_rule_bastion_2002,
    azurerm_network_security_rule.landing_zone_nsg_rule_bastion_2003
  ]
  subnet_id                 = var.subnet_data.id
  network_security_group_id = var.network_security_group_data.id
}

### Rules

#### Inbound Rules #####
#https://docs.microsoft.com/en-us/azure/bastion/bastion-nsg
resource "azurerm_network_security_rule" "landing_zone_nsg_rule_bastion_0001" {
  name                        = "Allow_Internet_to_BastionSubnet_Port443_Inbound"
  priority                    = 120
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "Internet"
  destination_address_prefix  = "*"
  resource_group_name         = var.rg_connectivity_name
  network_security_group_name = var.network_security_group_data.name
}
resource "azurerm_network_security_rule" "landing_zone_nsg_rule_bastion_0002" {
  name                        = "Allow_GatewayManager_to_BastionSubnet_Port443_Inbound"
  priority                    = 130
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "GatewayManager"
  destination_address_prefix  = "*"
  resource_group_name         = var.rg_connectivity_name
  network_security_group_name = var.network_security_group_data.name
}
resource "azurerm_network_security_rule" "landing_zone_nsg_rule_bastion_0003" {
  name                        = "Allow_AzureLoadBalancer_to_BastionSubnet_Port443_Inbound"
  priority                    = 140
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "AzureLoadBalancer"
  destination_address_prefix  = "*"
  resource_group_name         = var.rg_connectivity_name
  network_security_group_name = var.network_security_group_data.name
}
resource "azurerm_network_security_rule" "landing_zone_nsg_rule_bastion_0004" {
  name                        = "Allow_VirtualNetwork_to_VirtualNetwork_BastionHostCommunication_Inbound"
  priority                    = 150
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_ranges     = ["8080", "5701"]
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "VirtualNetwork"
  resource_group_name         = var.rg_connectivity_name
  network_security_group_name = var.network_security_group_data.name
}
#### Outbound Rules #####
resource "azurerm_network_security_rule" "landing_zone_nsg_rule_bastion_2000" {
  name                        = "Allow_BastionSubnet_to_VirtualNetwork_RDP_SSH_Outbound"
  priority                    = 2020
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_ranges     = ["3389", "22"]
  source_address_prefix       = "*"
  destination_address_prefix  = "VirtualNetwork"
  resource_group_name         = var.rg_connectivity_name
  network_security_group_name = var.network_security_group_data.name
}
resource "azurerm_network_security_rule" "landing_zone_nsg_rule_bastion_2001" {
  name                        = "Allow_BastionSubnet_to_AzureCloud_Port443_Outbound"
  priority                    = 2030
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "tcp"
  source_port_range           = "*"
  destination_port_ranges     = ["443"]
  source_address_prefix       = "*"
  destination_address_prefix  = "AzureCloud"
  resource_group_name         = var.rg_connectivity_name
  network_security_group_name = var.network_security_group_data.name
}
resource "azurerm_network_security_rule" "landing_zone_nsg_rule_bastion_2002" {
  name                        = "Allow_VirtualNetwork_to_VirtualNetwork_BastionHostCommunication_Outbound"
  priority                    = 2040
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_ranges     = ["8080", "5071"]
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "VirtualNetwork"
  resource_group_name         = var.rg_connectivity_name
  network_security_group_name = var.network_security_group_data.name
}
resource "azurerm_network_security_rule" "landing_zone_nsg_rule_bastion_2003" {
  name                        = "Allow_BastionSubnet_to_Internet_Port80_Outbound"
  priority                    = 2050
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_ranges     = ["80"]
  source_address_prefix       = "*"
  destination_address_prefix  = "Internet"
  resource_group_name         = var.rg_connectivity_name
  network_security_group_name = var.network_security_group_data.name
}

