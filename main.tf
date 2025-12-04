resource "azurerm_bastion_host" "this" {
  name                = var.bastion_subnet_id != null ? "bn-${local.vnet_name}" : "bn-${var.bastion_vnet_name}"
  location            = local.default_location
  resource_group_name = var.rg_bastion_name
  sku                 = var.sku
  ### Optional options ###
  copy_paste_enabled = var.copy_paste_enabled
  # Standard ONLY options
  scale_units        = var.sku == "Standard" ? var.scale_units : null
  ip_connect_enabled = var.sku == "Standard" ? var.ip_connect_enabled : null
  file_copy_enabled  = var.sku == "Standard" ? var.file_copy_enabled : null
  tunneling_enabled  = var.sku == "Standard" ? var.tunneling_enabled : null
  kerberos_enabled   = var.sku == "Standard" ? var.kerberos_enabled : null
  tags               = local.tags

  dynamic "ip_configuration" {
    for_each = var.create_pip ? [1] : []
    content {
      name                 = "configuration"
      subnet_id            = var.bastion_subnet_id != null ? var.bastion_subnet_id : azurerm_subnet.bastion.id
      public_ip_address_id = var.create_pip ? azurerm_public_ip.bastion.id : null
    }
  }
}

resource "azurerm_public_ip" "bastion" {
  count               = var.create_pip ? 1 : 0
  name                = "pip-prd-Bastion-01-${local.default_location}"
  location            = local.default_location
  resource_group_name = var.rg_bastion_name
  allocation_method   = "Static"
  sku                 = "Standard"

  lifecycle {
    ignore_changes = [tags]
  }  
}

# Azure Bastion Subnet
resource "azurerm_subnet" "bastion" {
  count                = var.bastion_subnet_id == null ? 1 : 0
  name                 = "AzureBastionSubnet" # Mandatory name - DO NOT CHANGE!!!
  resource_group_name  = var.rg_connectivity_name
  virtual_network_name = local.vnet_name
  address_prefixes     = [var.bastion_subnet_address]
}

### Associate 
# NSG association not possible for GatewaySubnet
resource "azurerm_subnet_network_security_group_association" "bastion" {
  subnet_id                 = var.bastion_subnet_id != null ? var.bastion_subnet_id : azurerm_subnet.bastion.id
  network_security_group_id = azurerm_network_security_group.bastion.id
}

