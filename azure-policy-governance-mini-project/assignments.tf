# --------------------------------------------------
# assignments.tf
# --------------------------------------------------
# This file assigns Azure Policy definitions
# to the current Azure subscription.
#
# Scope:
# - Subscription level governance
#
# Policies assigned:
# 1. Location restriction
# 2. VM size control
# 3. Mandatory tagging enforcement
#
# Subscription details are fetched using
# a Terraform data source to avoid
# hardcoding subscription IDs.
# NOTE:
# AzureRM v3+ requires scope-specific
# policy assignment resources.
# --------------------------------------------------


# --------------------------------------------------
# Assignment 1: Location Restriction Policy
# --------------------------------------------------
resource "azurerm_subscription_policy_assignment" "location_policy_assignment" {
  name                 = "location-restriction-assignment"
  display_name         = "Restrict resource locations"
  policy_definition_id = azurerm_policy_definition.location_restriction.id
  subscription_id      = data.azurerm_subscription.current.id
}


# --------------------------------------------------
# Assignment 2: VM Size Control Policy
# --------------------------------------------------
resource "azurerm_subscription_policy_assignment" "vm_size_policy_assignment" {
  name                 = "vm-size-control-assignment"
  display_name         = "Restrict VM sizes for cost control"
  policy_definition_id = azurerm_policy_definition.vm_size_control.id
  subscription_id      = data.azurerm_subscription.current.id
}


# --------------------------------------------------
# Assignment 3: Mandatory Tagging Policy
# --------------------------------------------------
resource "azurerm_subscription_policy_assignment" "mandatory_tags_policy_assignment" {
  name                 = "mandatory-tags-assignment"
  display_name         = "Enforce mandatory department and project tags"
  policy_definition_id = azurerm_policy_definition.mandatory_tags.id
  subscription_id      = data.azurerm_subscription.current.id
}
