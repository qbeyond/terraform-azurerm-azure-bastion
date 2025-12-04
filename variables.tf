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

variable "kerberos_enabled" {
  description = "Enable Kerberos authentication for Bastion Host, only available in the Standard tier"
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

variable "create_pip" {
  description = "Whether to create a new Public IP for the Azure Bastion Host. If true, a new Public IP will be created."
  type        = bool
  default     = true
}

variable "azurerm_version" {
  description = "Version of the azurerm provider to use."
  type        = string
  default     = "~> 3.117.1"
}

variable "security_rules" {
  description = "Each of the security rules assigned to the NSG."
  type = map(object({

    # (Optional) Description of the rule (up to 140 characters).
    description                          = optional(string)

    # (Required) Protocol: Tcp, Udp, Icmp, Esp, Ah or "*" (all).
    protocol                             = string

    # (Optional) Source port or port range. Required if source_port_ranges is not used.
    source_port_range                    = optional(string)

    # (Optional) List of source ports or port ranges. Required if source_port_range is not used.
    source_port_ranges                   = optional(list(string))

    # (Optional) Destination port or port range. Required if destination_port_ranges is not used.
    destination_port_range               = optional(string)

    # (Optional) List of destination ports or port ranges. Required if destination_port_range is not used.
    destination_port_ranges              = optional(list(string))

    # (Optional) Source address prefix (CIDR or tag: VirtualNetwork, AzureLoadBalancer, Internet). Required if source_address_prefixes is not used.
    source_address_prefix                = optional(string)

    # (Optional) List of source address prefixes (CIDR). Required if source_address_prefix is not used.
    source_address_prefixes              = optional(list(string))

    # (Optional) Destination address prefix (CIDR or tag: VirtualNetwork, AzureLoadBalancer, Internet, Service Tags). Required if destination_address_prefixes is not used.
    destination_address_prefix           = optional(string)

    # (Optional) List of destination address prefixes (CIDR). Required if destination_address_prefix is not used.
    destination_address_prefixes         = optional(list(string))

    # (Required) Defines whether to allow or deny traffic. Values: "Allow" or "Deny".
    access                               = string

    # (Required) Priority between 100 and 4096 (unique number; lower value means higher priority).
    priority                             = number

    # (Required) Traffic direction: "Inbound" or "Outbound".
    direction                            = string
  }))

  validation {
    condition = alltrue([
      for rule in values(var.security_rules) : (
        (
          (rule.source_address_prefix   != null && rule.source_address_prefixes   == null) ||
          (rule.source_address_prefix   == null && rule.source_address_prefixes   != null)
        ) && (
          (rule.source_port_range       != null && rule.source_port_ranges       == null) ||
          (rule.source_port_range       == null && rule.source_port_ranges       != null)
        ) && (
          (rule.destination_address_prefix   != null && rule.destination_address_prefixes   == null) ||
          (rule.destination_address_prefix   == null && rule.destination_address_prefixes   != null)
        ) && (
          (rule.destination_port_range   != null && rule.destination_port_ranges   == null) ||
          (rule.destination_port_range   == null && rule.destination_port_ranges   != null)
        )
      )
    ])
    error_message = <<-EOT
      Each rule must specify either:
        - source_address_prefix <---> source_address_prefixes
        - source_port_range <---> source_port_ranges
        - destination_address_prefix <---> destination_address_prefixes
        - destination_port_range <---> destination_port_ranges
        Check if you're not leaving them empty or filling them both.
      EOT
  }

  validation {
    condition = alltrue([
      for rule in values(var.security_rules) : contains([
        "Tcp",
        "Udp",
        "Icmp",
        "Esp",
        "Ah",
        "*"
      ], rule.protocol)
    ])
    error_message = <<-EOT
      protocol must be one of:
      "Tcp", "Udp", "Icmp", "Esp", "Ah", "*"
    EOT
  }

  # Validation: access must be "Allow" or "Deny"
  validation {
    condition = alltrue([
      for rule in values(var.security_rules) : contains([
        "Allow",
        "Deny"
      ], rule.access)
    ])
    error_message = <<-EOT
      access must be one of:
      "Allow", "Deny"
      EOT
  }

  # Validation: priority must be between 100 and 4095
  validation {
    condition = alltrue([
      for rule in values(var.security_rules) : (
        rule.priority >= 100 && rule.priority <= 4095
      )
    ])
    error_message = <<-EOT
      priority must be a number between 100 and 4095 (inclusive).
    EOT
  }

  # Validation: direction must be "Inbound" or "Outbound" (case insensitive)
  validation {
    condition = alltrue([
      for rule in values(var.security_rules) : contains([
        "inbound",
        "outbound"
      ], lower(rule.direction))
    ])
    error_message = <<-EOT
      direction must be "Inbound" or "Outbound" (case insensitive).
    EOT
  }
}