# # ------------------------------------------------------------
# # Storage Accounts using COUNT meta-argument
# # ------------------------------------------------------------
# resource "azurerm_storage_account" "sa_count" {
#   count                    = length(var.storage_account_names_count)   # Number of resources to create
#   name                     = var.storage_account_names_count[count.index] # Access list using index
#   resource_group_name      = azurerm_resource_group.rg.name
#   location                 = azurerm_resource_group.rg.location
#   account_tier             = "Standard"
#   account_replication_type = "LRS"

#   tags = local.common_tags
# }

# # ------------------------------------------------------------
# # Storage Accounts using FOR_EACH meta-argument
# # ------------------------------------------------------------
# resource "azurerm_storage_account" "sa_each" {
#   for_each                 = var.storage_accounts_map                  # Iterate over map
#   name                     = each.value                                # Storage account name
#   resource_group_name      = azurerm_resource_group.rg.name
#   location                 = azurerm_resource_group.rg.location
#   account_tier             = "Standard"
#   account_replication_type = "LRS"

#   tags = local.common_tags
# }
