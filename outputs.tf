output "azure_bastion" {
  value = azurerm_bastion_host.this
}

output "public_ip" {
  value = azurerm_public_ip.bastion
}

output "subnet_nsg_association" {
  value = azurerm_subnet_network_security_group_association.bastion
}
