variable "location" {
  description = "The region of a resource."
  type        = string
}

variable "rg_bastion_name" {
  description = "Azure Bastion Resource Group Name"
  type        = string
}

variable "rg_connectivity_name" {
  description = "Resource Group name where Azure Bastion VNet and Subnet are located"
  type        = string
}

variable "bastion_subnet_address" {
  description = "Address of the new Azure Bastion Subnet"
  type        = string
}

variable "bastion_vnet_name" {
  description = "Existing Azure Bastion VNET name"
  type        = string
}

variable "copy_paste_enabled" {
  description = "Enable clipboard copy-paste in Azure Bastion"
  type        = bool
  default     = null
}

### SKU ###

variable "sku" {
  description = "Bastion Tiers. (Basic, Standard)"
  type        = string
  default     = "Basic"
}

### Standard only options ###

variable "ip_connect_enabled" {
  description = "Azure Bastion connectivity via IP, only available in the Standard tier"
  type        = bool
  default     = true
}

variable "file_copy_enabled" {
  description = "Allows you to transfer files via Azure Bastion, only available in the Standard tier"
  type        = bool
  default     = null
}

variable "scale_units" {
  description = "Allows scale the number of 'backend instances/VMs' between 2-50 (default 2), <each unit/instance/VM allows 20 sessions>, by default is 2 (40 sessions) on Basic and Standard tier, but it can only be modified in the Standard tier"
  type        = number
  default     = null
}

variable "tunneling_enabled" {
  description = "The 'native client feature' <Name in Azure Portal, in Terraform is 'tunneling_enabled'> lets you connect to your target VMs via Bastion using Azure CLI, only available in the Standard tier"
  type        = bool
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "If specified, will set tags for all resources deployed by this module where supported."
  default     = null
}

variable "bastion_subnet_id" {
  description = "The ID of an existing subnet to use for the Azure Bastion Host. If not provided, a new subnet will be created."
  type        = string
  default     = null
}