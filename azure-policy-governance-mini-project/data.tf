# -------------------------------------------
# data.tf
# -------------------------------------------
# This file fetches existing Azure details
# using Terraform data sources.
#
# Purpose:
# - Avoid hardcoding subscription IDs
# - Make the configuration reusable
# - Follow best practices for governance
# -------------------------------------------

# Fetch details of the currently authenticated
# Azure subscription
data "azurerm_subscription" "current" {}

# Output the subscription ID for verification
# This helps confirm that policies are being
# applied to the correct subscription
output "subscription_id" {
  description = "Current Azure Subscription ID"
  value       = data.azurerm_subscription.current.subscription_id
}

# Output the subscription display name
# Useful for validation and debugging
output "subscription_name" {
  description = "Current Azure Subscription Name"
  value       = data.azurerm_subscription.current.display_name
}
