# Module
[![GitHub tag](https://img.shields.io/github/tag/qbeyond/terraform-module-template.svg)](https://registry.terraform.io/modules/qbeyond/terraform-module-template/provider/latest)
[![License](https://img.shields.io/github/license/qbeyond/terraform-module-template.svg)](https://github.com/qbeyond/terraform-module-template/blob/main/LICENSE)

----

This is a template module. It just showcases how a module should look. This would be a short description of the module.

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
  sku                         = "Standard"
}
```

## Requirements

No requirements.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bastion_subnet_address"></a> [bastion\_subnet\_address](#input\_bastion\_subnet\_address) | Azure Bastion Subnet address | `string` | n/a | yes |
| <a name="input_bastion_vnet_name"></a> [bastion\_vnet\_name](#input\_bastion\_vnet\_name) | Azure Bastion VNET name | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The region of a resource. | `string` | n/a | yes |
| <a name="input_rg_bastion_name"></a> [rg\_bastion\_name](#input\_rg\_bastion\_name) | Azure Bastion Resource Group Name | `string` | n/a | yes |
| <a name="input_rg_connectivity_name"></a> [rg\_connectivity\_name](#input\_rg\_connectivity\_name) | Resource Group name where Azure Bastion Subnet is located | `string` | n/a | yes |
| <a name="input_state"></a> [state](#input\_state) | The environment of the resource. (prd,dev,tst,int) | `string` | n/a | yes |
| <a name="input_sku"></a> [sku](#input\_sku) | Bastion Tiers. (Basic, Standard) | `string` | `"Basic"` | no |
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
| [azurerm_bastion_host.landing_zone_bastion_service](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/bastion_host) | resource |
| [azurerm_public_ip.landing_zone_vnet_pip_bastion](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_subnet.bastion](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet_network_security_group_association.landing_zone_nsg_association_bastion](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |

### rules.tf

| Name | Type |
|------|------|
| [azurerm_network_security_group.bastion](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
<!-- END_TF_DOCS -->

## Contribute

Please use Pull requests to contribute.

When a new Feature or Fix is ready to be released, create a new Github release and adhere to [Semantic Versioning 2.0.0](https://semver.org/lang/de/spec/v2.0.0.html).