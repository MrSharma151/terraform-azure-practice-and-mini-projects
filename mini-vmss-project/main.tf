# ------------------------------------------------------------
# Resource Group
# This file defines the base Resource Group for the project.
# All Azure resources will be created inside this RG.
# ------------------------------------------------------------

resource "azurerm_resource_group" "this" {

  # Name of the Resource Group
  # Passed as a variable to keep configuration reusable
  name = var.resource_group_name

  # Azure region where resources will be deployed
  location = var.location

  # Tags applied to the Resource Group
  # Helps with cost management, ownership, and environment clarity
  tags = local.common_tags
}
