# ------------------------------------------------------------
# Existing Resource Group (used as RBAC scope)
# ------------------------------------------------------------
data "azurerm_resource_group" "this" {

  name = var.resource_group_name
}
