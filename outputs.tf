output "azure_bastion" {
  value = azurerm_bastion_host.landing_zone_bastion_service
}

output "public_ip" {
  value = azurerm_public_ip.landing_zone_vnet_pip_bastion
}

output "subnet_nsg_association" {
  value = azurerm_subnet_network_security_group_association.landing_zone_nsg_association_bastion
}
