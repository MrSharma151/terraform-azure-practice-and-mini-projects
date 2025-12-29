# ------------------------------------------------------------
# Output resource group name
# ------------------------------------------------------------
output "resource_group_name" {
  description = "Name of the created resource group"
  value       = azurerm_resource_group.rg.name
}

# ------------------------------------------------------------
# Output storage account name
# ------------------------------------------------------------
output "storage_account_name" {
  description = "Name of the created storage account"
  value       = azurerm_storage_account.sa.name
}

# ------------------------------------------------------------
# Output storage account primary location
# ------------------------------------------------------------
output "storage_account_location" {
  description = "Location of the storage account"
  value       = azurerm_storage_account.sa.location
}
