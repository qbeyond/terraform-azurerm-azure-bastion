locals {
  default_location = var.location != null ? var.location : "westeurope"
  tags = var.tags

  vnet_name = split("/", var.bastion_subnet_id)[8]
  subnet_name = split("/", var.bastion_subnet_id)[10]

  subnet_parts = split("-", local.subnet_name)

  subnet_address = "${local.subnet_parts[1]}.${local.subnet_parts[2]}.${local.subnet_parts[3]}.${local.subnet_parts[4]}/${local.subnet_parts[5]}"

  subnet_numeric = join("-", slice(local.subnet_parts, 1, 6)) # e.g. 10-200-2-128-25
  new_subnet_numeric = var.bastion_subnet_id == null ? join("-", concat(split(".", split("/", var.bastion_subnet_address)[0]), [split("/", var.bastion_subnet_address)[1]])) : local.subnet_numeric

}