locals {
  default_location = var.location != null ? var.location : "westeurope"
  tags = var.tags

  vnet_name = split("/", var.bastion_subnet_id)[8]
  vnet_name_no_location = join("-", slice(split("-", vnet_name_raw), 0, length(split("-", vnet_name_raw)) - 1))

  subnet_name = split("/", var.bastion_subnet_id)[10]

  subnet_parts = split("-", local.subnet_name)

  subnet_address = "${local.subnet_parts[1]}.${local.subnet_parts[2]}.${local.subnet_parts[3]}.${local.subnet_parts[4]}/${local.subnet_parts[5]}"

  subnet_numeric = join("-", slice(local.subnet_parts, 1, 6)) # e.g. 10-200-2-128-25
  new_subnet_numeric = var.bastion_subnet_id == null ? join("-", concat(split(".", split("/", var.bastion_subnet_address)[0]), [split("/", var.bastion_subnet_address)[1]])) : local.subnet_numeric


  default_rules = {
    Allow-HTTPS-From-Internet = {
      protocol                     = "Tcp"
      source_port_range            = "*"
      destination_port_range       = "443"
      source_address_prefix        = "Internet"
      destination_address_prefix   = "*"
      access                       = "Allow"
      priority                     = 100
      direction                    = "Inbound"
    }

    Allow-HTTPS-From-GatewayManager = {
      protocol                     = "Tcp"
      source_port_range            = "*"
      destination_port_range       = "443"
      source_address_prefix        = "GatewayManager"
      destination_address_prefix   = "*"
      access                       = "Allow"
      priority                     = 110
      direction                    = "Inbound"
    }

    Allow-HTTPS-From-AzureLoadBalancer = {
      protocol                     = "Tcp"
      source_port_range            = "*"
      destination_port_range       = "443"
      source_address_prefix        = "AzureLoadBalancer"
      destination_address_prefix   = "*"
      access                       = "Allow"
      priority                     = 120
      direction                    = "Inbound"
    }

    Allow-DataPlane-8080-5701-Inbound = {
      protocol                     = "Tcp"
      source_port_range            = "*"
      destination_port_ranges      = ["8080", "5701"]
      source_address_prefix        = "VirtualNetwork"
      destination_address_prefix   = "VirtualNetwork"
      access                       = "Allow"
      priority                     = 130
      direction                    = "Inbound"
    }

    Allow-RDP-SSH-To-Jumphost = {
      protocol                     = "Tcp"
      source_port_range            = "*"
      destination_port_ranges      = ["3389", "22"]
      source_address_prefix        = "*"
      destination_address_prefix   = "VirtualNetwork"
      access                       = "Allow"
      priority                     = 140
      direction                    = "Inbound"
    }

    Allow-RDP-SSH-To-VNet = {
      protocol                     = "Tcp"
      source_port_range            = "*"
      destination_port_ranges      = ["3389", "22"]
      source_address_prefix        = "*"
      destination_address_prefix   = "VirtualNetwork"
      access                       = "Allow"
      priority                     = 200
      direction                    = "Outbound"
    }

    Allow-DataPlane-8080-5701-Outbound = {
      protocol                     = "Tcp"
      source_port_range            = "*"
      destination_port_ranges      = ["8080", "5701"]
      source_address_prefix        = "VirtualNetwork"
      destination_address_prefix   = "VirtualNetwork"
      access                       = "Allow"
      priority                     = 210
      direction                    = "Outbound"
    }

    Allow-HTTPS-To-AzureCloud = {
      protocol                     = "Tcp"
      source_port_range            = "*"
      destination_port_range       = "443"
      source_address_prefix        = "*"
      destination_address_prefix   = "AzureCloud"
      access                       = "Allow"
      priority                     = 220
      direction                    = "Outbound"
    }

    Allow-HTTP-To-Internet = {
      protocol                     = "Tcp"
      source_port_range            = "*"
      destination_port_range       = "80"
      source_address_prefix        = "*"
      destination_address_prefix   = "Internet"
      access                       = "Allow"
      priority                     = 230
      direction                    = "Outbound"
    }
  }

  effective_default_rules = {
    for name, rule in local.default_rules :
    name => rule
    if !contains(keys(var.security_rules), name)
  }

  merged_rules = merge(
    local.effective_default_rules,  # Default rules
    var.security_rules              # User-defined rules
  )
}