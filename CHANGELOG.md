# Changelog
All notable changes to this module will be documented in this file.
 
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this module adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).
 
## [Unreleased]

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