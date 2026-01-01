# ------------------------------------------------------------
# Outputs
# These outputs help validate created resources
# ------------------------------------------------------------

# ------------------------------------------------------------
# Resource Group (RBAC scope)
# ------------------------------------------------------------
output "resource_group_name" {
  description = "Existing Resource Group used as RBAC scope"
  value       = data.azurerm_resource_group.this.name
}

# ------------------------------------------------------------
# Azure AD Users
# ------------------------------------------------------------
output "azure_ad_users" {
  description = "List of Azure AD user principal names created"
  value = [
    for u in azuread_user.users : u.user_principal_name
  ]
}

# ------------------------------------------------------------
# Azure AD Groups
# ------------------------------------------------------------
output "azure_ad_groups" {
  description = "List of Azure AD security groups created"
  value = [
    for g in azuread_group.groups : g.display_name
  ]
}

# ------------------------------------------------------------
# RBAC Role Assignments (logical summary)
# ------------------------------------------------------------
output "rbac_role_assignments" {
  description = "RBAC role assignments applied at Resource Group level"
  value = {
    devops_admin = {
      role  = "Contributor"
      scope = data.azurerm_resource_group.this.name
    }

    app_team = {
      role  = "Contributor"
      scope = data.azurerm_resource_group.this.name
    }

    readonly = {
      role  = "Reader"
      scope = data.azurerm_resource_group.this.name
    }
  }
}
