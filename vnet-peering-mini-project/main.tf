# ------------------------------------------------------------
# Resource Group
# This resource group will contain all networking and VM resources
# for the VNet Peering mini project.
# ------------------------------------------------------------
resource "azurerm_resource_group" "this" {

  # Name of the resource group
  name = var.resource_group_name

  # Azure region where resources will be deployed
  location = var.location

  # Common tags applied to all resources
  tags = local.common_tags
}
