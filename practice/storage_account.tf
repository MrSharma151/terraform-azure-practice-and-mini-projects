# ------------------------------------------------------------
# Storage Account
# ------------------------------------------------------------
resource "azurerm_storage_account" "sa" {
  name                     = var.storage_account_name              # Storage account name from variable
  resource_group_name      = azurerm_resource_group.rg.name         # Reference to resource group
  location                 = azurerm_resource_group.rg.location    # Same location as resource group
  account_tier             = "Standard"                             # Storage performance tier
  account_replication_type = "LRS"                                  # Locally Redundant Storage

  tags = local.common_tags                                          # Tags from locals
}
