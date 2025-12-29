# ------------------------------------------------------------
# Resource Group
# ------------------------------------------------------------
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name   # Resource group name from variable
  location = var.location              # Azure region from variable
}