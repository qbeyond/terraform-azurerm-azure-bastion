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

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-01"
  address_space       = ["0.0.0.0/24"]
  dns_servers         = ["0.0.0.0", "1.1.1.1"]
  location            = "West Europe"
  resource_group_name = "rg-local"

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_subnet" "AzureBastionSubnet" {
  name                 = "bn-vnet-01"
  resource_group_name  = "rg-local"
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["0.0.0.0/26"]
}

module "azureBastion" {
  source                      = "../../"
  location                    = "West Europe"
  state                       = "dev"
  rg_connectivity_name        = "rg-connectivity-01"
  rg_management_name          = "rg-management-01"
  subnet_data                 = 
  network_security_group_data = 
}
```

## Requirements

No requirements.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_location"></a> [location](#input\_location) | The region of a resource. | `string` | n/a | yes |
| <a name="input_network_security_group_data"></a> [network\_security\_group\_data](#input\_network\_security\_group\_data) | complete data from Network Security Group of the vnet. azurerm\_network\_security\_group.nsg | `any` | n/a | yes |
| <a name="input_rg_connectivity_name"></a> [rg\_connectivity\_name](#input\_rg\_connectivity\_name) | Resource Group name where Azure Bastion Subnet is located | `string` | n/a | yes |
| <a name="input_rg_management_name"></a> [rg\_management\_name](#input\_rg\_management\_name) | Resource Group name where Azure Bastion Service will be deployed to | `string` | n/a | yes |
| <a name="input_state"></a> [state](#input\_state) | The environment of the resource. (prd,dev,tst,int) | `string` | n/a | yes |
| <a name="input_subnet_data"></a> [subnet\_data](#input\_subnet\_data) | Complete data from AzureBastionSubnet Subnet Terraform Ressorce in Vnet. Azurerm\_subnet.subnet | `any` | n/a | yes |
## Outputs

No outputs.

## Resource types

| Type | Used |
|------|-------|
| [azurerm_bastion_host](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/bastion_host) | 1 |
| [azurerm_network_security_rule](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | 8 |
| [azurerm_public_ip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | 1 |
| [azurerm_subnet_network_security_group_association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | 1 |

**`Used` only includes resource blocks.** `for_each` and `count` meta arguments, as well as resource blocks of modules are not considered.

## Modules

No modules.

## Resources by Files

### main.tf

| Name | Type |
|------|------|
| [azurerm_bastion_host.landing_zone_bastion_service](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/bastion_host) | resource |
| [azurerm_network_security_rule.landing_zone_nsg_rule_bastion_0001](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.landing_zone_nsg_rule_bastion_0002](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.landing_zone_nsg_rule_bastion_0003](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.landing_zone_nsg_rule_bastion_0004](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.landing_zone_nsg_rule_bastion_2000](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.landing_zone_nsg_rule_bastion_2001](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.landing_zone_nsg_rule_bastion_2002](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.landing_zone_nsg_rule_bastion_2003](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_public_ip.landing_zone_vnet_pip_bastion](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_subnet_network_security_group_association.landing_zone_nsg_association_bastion](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
<!-- END_TF_DOCS -->

## Contribute

Please use Pull requests to contribute.

When a new Feature or Fix is ready to be released, create a new Github release and adhere to [Semantic Versioning 2.0.0](https://semver.org/lang/de/spec/v2.0.0.html).