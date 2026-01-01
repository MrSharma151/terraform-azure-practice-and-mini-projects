# ------------------------------------------------------------
# Azure Active Directory configuration
# This file manages:
# - Azure AD users
# - Azure AD security groups
# - Group membership mappings
# ------------------------------------------------------------

# ------------------------------------------------------------
# Azure AD Users
# Users are created using first_name and last_name
# ------------------------------------------------------------
resource "azuread_user" "users" {

  # Use NON-sensitive local map for iteration
  # This avoids Terraform errors with sensitive values
  for_each = local.users_for_each

  # Display name shown in Azure AD
  display_name = "${each.value.first_name} ${each.value.last_name}"

  # User Principal Name (email address)
  # Format: firstname.lastname@tenant_domain
  user_principal_name = lower(
    "${replace(each.value.first_name, " ", "")}.${replace(each.value.last_name, " ", "")}@${var.tenant_domain}"
  )

  # Initial password 
  # User will be forced to reset password on first login
  password = var.users[each.key].password

  force_password_change = true

  # Mail nickname must be unique within the tenant
  mail_nickname = lower(
    "${replace(each.value.first_name, " ", "")}${replace(each.value.last_name, " ", "")}"
  )

  # Enable the user account
  account_enabled = true
}

# ------------------------------------------------------------
# Azure AD Security Groups
# These groups will be used for RBAC assignments
# ------------------------------------------------------------
resource "azuread_group" "groups" {

  for_each = var.groups

  # Group display name
  display_name = each.value.display_name

  # Must be true for Azure RBAC support
  security_enabled = true

  # Description for documentation clarity
  description = each.value.description
}

# ------------------------------------------------------------
# Azure AD Group Memberships
# Users are assigned to groups based on mapping
# ------------------------------------------------------------
resource "azuread_group_member" "membership" {

  # Flatten group → user mappings into individual assignments
  for_each = {
    for item in flatten([
      for group_key, group in var.group_membership : [
        for user_key in group.users : {
          group_key = group_key
          user_key  = user_key
        }
      ]
    ]) :
    "${item.group_key}-${item.user_key}" => item
  }

  # Azure AD Group Object ID
  group_object_id = azuread_group.groups[each.value.group_key].id

  # Azure AD User Object ID
  member_object_id = azuread_user.users[each.value.user_key].id
}
