################################################################################
# Locals
################################################################################
locals {
  contact     = var.contact
  environment = var.environment
  team        = var.team
  purpose     = var.purpose

  resource_prefix                 = "${local.team}-${local.environment}"
}