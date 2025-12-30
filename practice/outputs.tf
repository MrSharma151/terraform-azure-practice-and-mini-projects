# ------------------------------------------------------------
# Output resource group name
# ------------------------------------------------------------
output "resource_group_name" {
  description = "Name of the created resource group"
  value       = azurerm_resource_group.rg.name
}

# # ------------------------------------------------------------
# # Output all storage account names created using COUNT
# # ------------------------------------------------------------
# output "storage_accounts_created_with_count" {
#   description = "List of storage account names created using count"
#   value = [
#     for sa in azurerm_storage_account.sa_count :
#     sa.name
#   ]
# }

# # ------------------------------------------------------------
# # Output all storage account names created using FOR_EACH
# # ------------------------------------------------------------
# output "storage_accounts_created_with_for_each" {
#   description = "List of storage account names created using for_each"
#   value = [
#     for sa in azurerm_storage_account.sa_each :
#     sa.name
#   ]
# }

