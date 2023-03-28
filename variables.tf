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

variable "sku" {
  description = "Bastion Tiers. (Basic, Standard)"
  type        = string
  default     = "Basic"
}

variable "bastion_vnet_name" {
  description = "Azure Bastion VNET name"
  type        = string
}

variable "bastion_subnet_address" {
  description = "Azure Bastion Subnet address"
  type        = string
}

variable "rg_bastion_name" {
  description = "Azure Bastion Resource Group Name"
  type        = string
}