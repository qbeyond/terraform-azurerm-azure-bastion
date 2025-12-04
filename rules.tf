resource "azurerm_network_security_group" "bastion" {
  name                = "nsg-${local.vnet_name_no_location}-bastion"
  location            = local.default_location
  resource_group_name = var.rg_bastion_name

  dynamic "security_rule" {
    for_each = local.merged_rules
    content {
      name       = security_rule.key
      priority   = security_rule.value.priority
      direction  = security_rule.value.direction
      access     = security_rule.value.access
      protocol   = security_rule.value.protocol

      source_port_range  = try(security_rule.value.source_port_range, null)
      source_port_ranges = try(security_rule.value.source_port_ranges, null)

      destination_port_range  = try(security_rule.value.destination_port_range, null)
      destination_port_ranges = try(security_rule.value.destination_port_ranges, null)

      source_address_prefix   = try(security_rule.value.source_address_prefix, null)
      source_address_prefixes = try(security_rule.value.source_address_prefixes, null)

      destination_address_prefix   = try(security_rule.value.destination_address_prefix, null)
      destination_address_prefixes = try(security_rule.value.destination_address_prefixes, null)
    }
  }

  security_rule {
    name                       = var.bastion_subnet_id != null ? "Deny-${local.safe_subnet_numeric}-to-${local.safe_subnet_numeric}-Any-Inbound" : "Deny-${local.safe_new_subnet_numeric}-to-${local.safe_new_subnet_numeric}-Any-Inbound"
    priority                   = 4096
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = var.use_existing_subnet ? local.subnet_address : azurerm_subnet.bastion[0].address_prefixes[0]
    destination_address_prefix = var.use_existing_subnet ? local.subnet_address : azurerm_subnet.bastion[0].address_prefixes[0]
  }

  tags = local.tags
}