# --------------------------------------------------
# policies.tf
# --------------------------------------------------
# This file defines all CUSTOM Azure Policy
# definitions used for governance.
#
# Policies covered:
# 1. Location restriction
# 2. VM size control (cost governance)
# 3. Mandatory tagging enforcement
#
# All policies are defined as "Custom"
# and will later be assigned at
# subscription scope.
# --------------------------------------------------


# --------------------------------------------------
# Policy 1: Location Restriction
# --------------------------------------------------
# This policy restricts resource creation
# to approved Azure regions only.
#
# Allowed locations:
# - eastus
# - westus
#
# Any resource created outside these
# regions will be DENIED.
# --------------------------------------------------
resource "azurerm_policy_definition" "location_restriction" {
  name         = "restrict-resource-locations"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "Allow resources only in approved regions"

  policy_rule = jsonencode({
    if = {
      not = {
        field = "location"
        in = [
          "eastus",
          "westus"
        ]
      }
    }
    then = {
      effect = "Deny"
    }
  })
}


# --------------------------------------------------
# Policy 2: VM Size Control (Cost Governance)
# --------------------------------------------------
# This policy restricts Virtual Machine
# creation to only approved, cost-effective
# VM sizes.
#
# Allowed VM sizes:
# - Standard_B2s
# - Standard_B2ms
#
# Any VM created with a different SKU
# will be DENIED.
# --------------------------------------------------
resource "azurerm_policy_definition" "vm_size_control" {
  name         = "restrict-vm-sizes"
  policy_type  = "Custom"
  mode         = "Indexed"
  display_name = "Allow only approved VM sizes"

  policy_rule = jsonencode({
    if = {
      allOf = [
        {
          field  = "type"
          equals = "Microsoft.Compute/virtualMachines"
        },
        {
          not = {
            field = "Microsoft.Compute/virtualMachines/sku.name"
            in = [
              "Standard_B2s",
              "Standard_B2ms"
            ]
          }
        }
      ]
    }
    then = {
      effect = "Deny"
    }
  })
}


# --------------------------------------------------
# Policy 3: Mandatory Tagging Enforcement
# --------------------------------------------------
# This policy enforces mandatory tags
# on all supported resources.
#
# Required tags:
# - department
# - project
#
# If any of these tags are missing,
# resource creation will be DENIED.
# --------------------------------------------------
resource "azurerm_policy_definition" "mandatory_tags" {
  name         = "enforce-mandatory-tags"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "Enforce mandatory department and project tags"

  policy_rule = jsonencode({
    if = {
      anyOf = [
        {
          field  = "tags.department"
          exists = "false"
        },
        {
          field  = "tags.project"
          exists = "false"
        }
      ]
    }
    then = {
      effect = "Deny"
    }
  })
}
