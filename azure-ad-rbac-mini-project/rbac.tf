# ------------------------------------------------------------
# RBAC Assignments at Resource Group level
# Access is granted using Azure AD security groups
# ------------------------------------------------------------

# ------------------------------------------------------------
# DevOps Admins -> Contributor access
# ------------------------------------------------------------
resource "azurerm_role_assignment" "devops_contributor" {

  scope                = data.azurerm_resource_group.this.id
  role_definition_name = "Contributor"

  # Azure AD group object ID
  principal_id = azuread_group.groups["devops_admin"].object_id

  # Avoid Azure AD replication timing issues
  skip_service_principal_aad_check = true
}

# ------------------------------------------------------------
# Application Team -> Contributor access
# ------------------------------------------------------------
resource "azurerm_role_assignment" "app_contributor" {

  scope                = data.azurerm_resource_group.this.id
  role_definition_name = "Contributor"

  principal_id = azuread_group.groups["app_team"].object_id

  skip_service_principal_aad_check = true
}

# ------------------------------------------------------------
# Read-only Users -> Reader access
# ------------------------------------------------------------
resource "azurerm_role_assignment" "readonly" {

  scope                = data.azurerm_resource_group.this.id
  role_definition_name = "Reader"

  principal_id = azuread_group.groups["readonly"].object_id

  skip_service_principal_aad_check = true
}
