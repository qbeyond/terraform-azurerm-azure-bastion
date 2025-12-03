resource "azurerm_network_security_group" "bastion" {
  name                = "nsg-vnet-10-200-2-128-25-bastion"
  location            = local.default_location
  resource_group_name = var.rg_bastion_name

  security_rule {
    name                       = "Allow-HTTPS-From-Internet"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-HTTPS-From-GatewayManager"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "GatewayManager"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-HTTPS-From-AzureLoadBalancer"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "AzureLoadBalancer"
    destination_address_prefix = "*"
  }

  security_rule {
    name                        = "Allow-DataPlane-8080-5701-Inbound"
    priority                    = 130
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_ranges     = ["8080", "5701"]
    source_address_prefix       = "VirtualNetwork"
    destination_address_prefix  = "VirtualNetwork"
  }

  security_rule {
    name                        = "Allow-RDP-SSH-To-Jumphost"
    priority                    = 140
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_ranges     = ["3389", "22"]
    source_address_prefix       = "*"
    destination_address_prefix  = "VirtualNetwork"
  }

  security_rule {
    name                        = "Allow-RDP-SSH-To-VNet"
    priority                    = 200
    direction                   = "Outbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_ranges     = ["3389", "22"]
    source_address_prefix       = "*"
    destination_address_prefix  = "VirtualNetwork"
  }

  security_rule {
    name                        = "Allow-DataPlane-8080-5701-Outbound"
    priority                    = 210
    direction                   = "Outbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_ranges     = ["8080", "5701"]
    source_address_prefix       = "VirtualNetwork"
    destination_address_prefix  = "VirtualNetwork"
  }

  security_rule {
    name                        = "Allow-HTTPS-To-AzureCloud"
    priority                    = 220
    direction                   = "Outbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "443"
    source_address_prefix       = "*"
    destination_address_prefix  = "AzureCloud"
  }

  security_rule {
    name                        = "Allow-HTTP-To-Internet"
    priority                    = 230
    direction                   = "Outbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "80"
    source_address_prefix       = "*"
    destination_address_prefix  = "Internet"
  }

  dynamic "security_rule" {
    for_each = var.security_rules
    content {
      name        = security_rule.key
      priority    = security_rule.value.priority
      direction   = security_rule.value.direction
      access      = security_rule.value.access
      protocol    = security_rule.value.protocol

      source_port_range  = try(security_rule.value.source_port_range, null)
      source_port_ranges = try(security_rule.value.source_port_ranges, null)

      destination_port_range  = try(security_rule.value.destination_port_range, null)
      destination_port_ranges = try(security_rule.value.destination_port_ranges, null)

      source_address_prefix  = try(security_rule.value.source_address_prefix, null)
      source_address_prefixes = try(security_rule.value.source_address_prefixes, null)

      destination_address_prefix  = try(security_rule.value.destination_address_prefix, null)
      destination_address_prefixes = try(security_rule.value.destination_address_prefixes, null)
    }
  }

  security_rule {
    name                       = var.bastion_subnet_id != null ? "Deny-${local.subnet_numeric}-to-${local.subnet_numeric}-Any-Inbound" : "Deny-${local.new_subnet_numeric}-to-${local.new_subnet_numeric}-Any-Inbound"
    priority                   = 4096
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = var.bastion_subnet_id != null ? local.subnet_address : azurerm_subnet.bastion.address_prefixes[0]
    destination_address_prefix = var.bastion_subnet_id != null ? local.subnet_address : azurerm_subnet.bastion.address_prefixes[0]
  }

  tags = local.tags
}