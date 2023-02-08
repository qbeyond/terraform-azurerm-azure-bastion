# Module
[![GitHub tag](https://img.shields.io/github/tag/qbeyond/terraform-module-template.svg)](https://registry.terraform.io/modules/qbeyond/terraform-module-template/provider/latest)
[![License](https://img.shields.io/github/license/qbeyond/terraform-module-template.svg)](https://github.com/qbeyond/terraform-module-template/blob/main/LICENSE)

----

This is a template module. It just showcases how a module should look. This would be a short description of the module.

<!-- BEGIN_TF_DOCS -->
## Usage

It's very easy to use!
```hcl

```

## Requirements

No requirements.

## Inputs

No inputs.
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