# Azure Bastion
[![GitHub tag](https://img.shields.io/github/tag/qbeyond/terraform-azurerm-azure-bastion.svg)](https://registry.terraform.io/modules/qbeyond/azure-bastion/azurerm/latest)
[![License](https://img.shields.io/github/license/qbeyond/terraform-azurerm-azure-bastion.svg)](https://github.com/qbeyond/terraform-azurerm-azure-bastion/blob/main/LICENSE)

----

This module creates an Azure Bastion with all its possible options and also creates by itself the NSG and Subnets that would need.

<!-- BEGIN_TF_DOCS -->
## Usage

It's very easy to use!
```hcl
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "connectivity" {
  name     = "rg-Connectivity-01"
  location = "westeurope"
}

resource "azurerm_resource_group" "bastion" {
  name     = "rg-ManagementBastion-prd-01"
  location = "westeurope"
}

resource "azurerm_virtual_network" "example" {
  name                = "examplevnet"
  address_space       = ["192.168.33.0/24"]
  location            = azurerm_resource_group.connectivity.location
  resource_group_name = azurerm_resource_group.connectivity.name
}

module "azureBastion" {
  source                      = "../../"
  location                    = "westeurope"
  state                       = "dev"
  rg_connectivity_name        = azurerm_resource_group.connectivity.name
  rg_bastion_name             = azurerm_resource_group.bastion.name
  bastion_vnet_name           = azurerm_virtual_network.example.name
  bastion_subnet_address      = "192.168.33.192/26"
  sku                         = "Basic"
  # Following variables are optional
  copy_paste_enabled          = true
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.117.1 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_location"></a> [location](#input\_location) | The region of a resource. | `string` | n/a | yes |
| <a name="input_rg_bastion_name"></a> [rg\_bastion\_name](#input\_rg\_bastion\_name) | Azure Bastion Resource Group Name | `string` | n/a | yes |
| <a name="input_bastion_subnet_address"></a> [bastion\_subnet\_address](#input\_bastion\_subnet\_address) | Address of the new Azure Bastion Subnet | `string` | `null` | no |
| <a name="input_bastion_subnet_id"></a> [bastion\_subnet\_id](#input\_bastion\_subnet\_id) | The ID of an existing subnet to use for the Azure Bastion Host. If not provided, a new subnet will be created. | `string` | `null` | no |
| <a name="input_bastion_vnet_name"></a> [bastion\_vnet\_name](#input\_bastion\_vnet\_name) | Existing Azure Bastion VNET name | `string` | `null` | no |
| <a name="input_copy_paste_enabled"></a> [copy\_paste\_enabled](#input\_copy\_paste\_enabled) | Enable clipboard copy-paste in Azure Bastion | `bool` | `null` | no |
| <a name="input_create_pip"></a> [create\_pip](#input\_create\_pip) | Whether to create a new Public IP for the Azure Bastion Host. If true, a new Public IP will be created. | `bool` | `true` | no |
| <a name="input_file_copy_enabled"></a> [file\_copy\_enabled](#input\_file\_copy\_enabled) | Allows you to transfer files via Azure Bastion, only available in the Standard tier | `bool` | `null` | no |
| <a name="input_ip_connect_enabled"></a> [ip\_connect\_enabled](#input\_ip\_connect\_enabled) | Azure Bastion connectivity via IP, only available in the Standard tier | `bool` | `true` | no |
| <a name="input_kerberos_enabled"></a> [kerberos\_enabled](#input\_kerberos\_enabled) | Enable Kerberos authentication for Bastion Host, only available in the Standard tier | `bool` | `null` | no |
| <a name="input_nsg_id"></a> [nsg\_id](#input\_nsg\_id) | The ID of an existing Network Security Group to associate with the Azure Bastion Subnet. If not provided, a new NSG will be created. | `string` | `null` | no |
| <a name="input_rg_connectivity_name"></a> [rg\_connectivity\_name](#input\_rg\_connectivity\_name) | Resource Group name where Azure Bastion VNet and Subnet are located | `string` | `null` | no |
| <a name="input_scale_units"></a> [scale\_units](#input\_scale\_units) | Allows scale the number of 'backend instances/VMs' between 2-50 (default 2), <each unit/instance/VM allows 20 sessions>, by default is 2 (40 sessions) on Basic and Standard tier, but it can only be modified in the Standard tier | `number` | `null` | no |
| <a name="input_security_rules"></a> [security\_rules](#input\_security\_rules) | Each of the security rules assigned to the NSG. | <pre>map(object({<br/><br/>    # (Optional) Description of the rule (up to 140 characters).<br/>    description                          = optional(string)<br/><br/>    # (Required) Protocol: Tcp, Udp, Icmp, Esp, Ah or "*" (all).<br/>    protocol                             = string<br/><br/>    # (Optional) Source port or port range. Required if source_port_ranges is not used.<br/>    source_port_range                    = optional(string)<br/><br/>    # (Optional) List of source ports or port ranges. Required if source_port_range is not used.<br/>    source_port_ranges                   = optional(list(string))<br/><br/>    # (Optional) Destination port or port range. Required if destination_port_ranges is not used.<br/>    destination_port_range               = optional(string)<br/><br/>    # (Optional) List of destination ports or port ranges. Required if destination_port_range is not used.<br/>    destination_port_ranges              = optional(list(string))<br/><br/>    # (Optional) Source address prefix (CIDR or tag: VirtualNetwork, AzureLoadBalancer, Internet). Required if source_address_prefixes is not used.<br/>    source_address_prefix                = optional(string)<br/><br/>    # (Optional) List of source address prefixes (CIDR). Required if source_address_prefix is not used.<br/>    source_address_prefixes              = optional(list(string))<br/><br/>    # (Optional) Destination address prefix (CIDR or tag: VirtualNetwork, AzureLoadBalancer, Internet, Service Tags). Required if destination_address_prefixes is not used.<br/>    destination_address_prefix           = optional(string)<br/><br/>    # (Optional) List of destination address prefixes (CIDR). Required if destination_address_prefix is not used.<br/>    destination_address_prefixes         = optional(list(string))<br/><br/>    # (Required) Defines whether to allow or deny traffic. Values: "Allow" or "Deny".<br/>    access                               = string<br/><br/>    # (Required) Priority between 100 and 4096 (unique number; lower value means higher priority).<br/>    priority                             = number<br/><br/>    # (Required) Traffic direction: "Inbound" or "Outbound".<br/>    direction                            = string<br/>  }))</pre> | `null` | no |
| <a name="input_sku"></a> [sku](#input\_sku) | Bastion Tiers. (Basic, Standard) | `string` | `"Basic"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | If specified, will set tags for all resources deployed by this module where supported. | `map(string)` | `null` | no |
| <a name="input_tunneling_enabled"></a> [tunneling\_enabled](#input\_tunneling\_enabled) | The 'native client feature' <Name in Azure Portal, in Terraform is 'tunneling\_enabled'> lets you connect to your target VMs via Bastion using Azure CLI, only available in the Standard tier | `bool` | `null` | no |
| <a name="input_use_existing_subnet"></a> [use\_existing\_subnet](#input\_use\_existing\_subnet) | If true, use an existing subnet provided in bastion\_subnet\_id; if false, create the AzureBastionSubnet. | `bool` | `false` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azure_bastion"></a> [azure\_bastion](#output\_azure\_bastion) | n/a |
| <a name="output_public_ip"></a> [public\_ip](#output\_public\_ip) | n/a |
| <a name="output_subnet_nsg_association"></a> [subnet\_nsg\_association](#output\_subnet\_nsg\_association) | n/a |

      ## Resource types

      | Type | Used |
      |------|-------|
        | [azurerm_bastion_host](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/bastion_host) | 1 |
        | [azurerm_network_security_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | 1 |
        | [azurerm_public_ip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | 1 |
        | [azurerm_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | 1 |
        | [azurerm_subnet_network_security_group_association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | 1 |

      **`Used` only includes resource blocks.** `for_each` and `count` meta arguments, as well as resource blocks of modules are not considered.
    
## Modules

No modules.

        ## Resources by Files

            ### main.tf

            | Name | Type |
            |------|------|
                  | [azurerm_bastion_host.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/bastion_host) | resource |
                  | [azurerm_public_ip.bastion](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
                  | [azurerm_subnet.bastion](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
                  | [azurerm_subnet_network_security_group_association.bastion](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |

            ### rules.tf

            | Name | Type |
            |------|------|
                  | [azurerm_network_security_group.bastion](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
    
<!-- END_TF_DOCS -->

## Contribute

Please use Pull requests to contribute.

When a new Feature or Fix is ready to be released, create a new Github release and adhere to [Semantic Versioning 2.0.0](https://semver.org/lang/de/spec/v2.0.0.html).