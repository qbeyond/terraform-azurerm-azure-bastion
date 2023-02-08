variable "location" {
  description = "The region of a resource."
  type        = string
}
variable "state" {
  description = "The environment of the resource. (prd,dev,tst,int)"
  type        = string
}
variable "rg_connectivity_name" {
  description = "Resource Group name where Azure Bastion Subnet is located"
  type        = string
}
variable "rg_management_name" {
  description = "Resource Group name where Azure Bastion Service will be deployed to"
  type        = string
}
variable "subnet_data" {
  description = "Complete data from AzureBastionSubnet Subnet Terraform Ressorce in Vnet. Azurerm_subnet.subnet"
}
variable "network_security_group_data" {
  description = "complete data from Network Security Group of the vnet. azurerm_network_security_group.nsg"
}
