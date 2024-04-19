resource "azurerm_bastion_host" "landing_zone_bastion_service" {
  name                   = "bn-${var.bastion_vnet_name}"
  location               = var.location
  resource_group_name    = var.rg_bastion_name
  sku                    = var.sku
  ### Optional options ###
  copy_paste_enabled     = var.copy_paste_enabled
  # Standard ONLY options
  scale_units            = var.sku == "Standard" ? var.scale_units : null
  ip_connect_enabled     = var.sku == "Standard" ? var.ip_connect_enabled : null
  file_copy_enabled      = var.sku == "Standard" ? var.file_copy_enabled : null
  tunneling_enabled      = var.sku == "Standard" ? var.tunneling_enabled : null
  shareable_link_enabled = var.sku == "Standard" ? var.shareable_link_enabled : null
  tags                   = var.tags

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.bastion.id
    public_ip_address_id = azurerm_public_ip.landing_zone_vnet_pip_bastion.id
  }
}

resource "azurerm_public_ip" "landing_zone_vnet_pip_bastion" {
  name                = "pip-${var.state}-LandingZoneBastion-01-${var.location}"
  resource_group_name = var.rg_connectivity_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

# Azure Bastion Subnet
resource "azurerm_subnet" "bastion" {
  name                 = "AzureBastionSubnet" # Mandatory name - DO NOT CHANGE!!!
  resource_group_name  = var.rg_connectivity_name
  virtual_network_name = var.bastion_vnet_name
  address_prefixes     = [var.bastion_subnet_address]
}

### Associate 
# NSG association not possible for GatewaySubnet
resource "azurerm_subnet_network_security_group_association" "landing_zone_nsg_association_bastion" {
  subnet_id                 = azurerm_subnet.bastion.id
  network_security_group_id = azurerm_network_security_group.bastion.id
}

