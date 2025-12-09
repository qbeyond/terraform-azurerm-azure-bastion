# Changelog
All notable changes to this module will be documented in this file.
 
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this module adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).
 
## [Unreleased]

## [2.4.0] - 2025-12-08

New variable to control creation of nsg

### Added

use_existing_nsg variable to control creation of new nsg
azurerm_bastion_name to directly name the bastion host and avoid re-creations

### Changed

### Removed

### Fixed

## [2.3.0] - 2025-12-04

New variable to control creation of nsg

### Added

nsg_id variable to allow association with existing subnet

### Changed

### Removed

### Fixed

## [2.2.0] - 2025-12-04

New variable to control creation of resources

### Added

Flag to create subnet and public ip

### Changed

### Removed

### Fixed

## [2.1.1] - 2025-12-04

Multiple changes

### Added

### Changed

Nsg naming

### Removed

### Fixed

## [2.1.0] - 2025-12-04

Multiple changes

### Added

Locals to ease the workflow of the module
Validations

### Changed

### Removed

### Fixed

## [2.0.7] - 2025-12-04

Deleted azurerm variable

### Added

### Changed

### Removed

azurerm variable

### Fixed

## [2.0.6] - 2025-12-04

Set unrequired variables

### Added

### Changed

Changed some variables to unrequired

### Removed

### Fixed

## [2.0.5] - 2025-12-04

Set unrequired variables

### Added

### Changed

Changed some variables to unrequired

### Removed

### Fixed

## [2.0.4] - 2025-12-04

azurerm to variable

### Added

### Changed

Changed azurerm version to variable

### Removed

### Fixed

## [2.0.3] - 2025-12-04

Downgraded azurerm version

### Added

### Changed

Downgraded azurerm version

### Removed

### Fixed

## [2.0.2] - 2025-12-04

Variable to add kerberos

### Added

Variable to add kerberos

### Changed

### Removed

### Fixed

## [2.0.1] - 2025-12-03

Flag for creating a Public IP and additional security rules

### Added

Flag for creating a Public IP
Variable "security_rules" to add additional security rules to the nsg
Capability to override default Bastion rules

### Changed

### Removed

### Fixed

## [2.0.0] - 2025-12-03

Up-to-date and new functionalities

### Added

Variable bastion subnet id to allow existing subnets and not create new ones
Several locals to ease the usage of the module

### Changed

Adjusted naming convention on all resources
Nsg to match current bastion rules and a custom deny rule

### Removed

Deleted variable "shareable_link_enabled" as it is no longer used

### Fixed

## [1.1.0] - 2024-04-19

Tagging resources.

### Added

Variable Tags for tagging the resources that accept tags.

### Changed

### Removed

### Fixed

## [1.0.5] - 2023-03-29

All Azure Bastion options + new example.

### Added

This module is backwards compatible with v1.0.4 (only), and adds all the options actually available for Azure Bastion, plus a new example.

### Changed

### Removed

### Fixed

## [1.0.4] - 2023-03-28

Sku options.

### Added

This new release add compatibility for choosing between Azure Bastion tiers (Basic and Standard).

Warning:
This release it's not compatible with the old one "v1.0.3", because now the main resources are inside the module (Subnet and NSG).

### Changed

### Removed

### Fixed

## [1.0.3] - 2023-02-14

Update Nsg Rule in Main.tf.

### Added

### Changed

Changed nsg rule protocol from tcp -> Tcp, case sensitive.

### Removed

### Fixed

## [1.0.2] - 2023-02-14

Update azurerm constraint.

### Added

### Changed
 
### Removed

### Fixed

Error with constraint 3.7.0. Had to be updated back to 3.0.0.

## [1.0.1] - 2023-02-08

Update Outputs.

### Added

### Changed

Outputs.
 
### Removed

### Fixed

## [1.0.0] - 2023-02-08

Initial code that create Bastion.

### Added

### Changed
 
### Removed

### Fixed