# --------------------------------------------------
# test-resources.tf
# --------------------------------------------------
# This file is used ONLY for testing
# Azure Policy enforcement.
#
# We are creating Resource Groups
# because:
# - They are free
# - No cost involved
# - Policies apply to them as well
#
# Test cases covered:
# 1. Non-compliant resource groups (expected to FAIL)
# 2. Compliant resource group (expected to SUCCEED)
#
# NOTE:
# - Apply one test at a time
# - Comment/uncomment resources as needed
# --------------------------------------------------


# --------------------------------------------------
# Test Case 1: Non-compliant Location
# --------------------------------------------------
# This resource group uses a location
# that is NOT allowed by policy.
#
# Expected Result:
# - Terraform apply should FAIL
# - Error should mention policy violation
# --------------------------------------------------

# resource "azurerm_resource_group" "non_compliant_location" {
#   name     = "rg-noncompliant-location"
#   location = "centralindia"
# }


# --------------------------------------------------
# Test Case 2: Non-compliant Tags
# --------------------------------------------------
# This resource group is missing
# mandatory tags (department, project).
#
# Expected Result:
# - Terraform apply should FAIL
# --------------------------------------------------

# resource "azurerm_resource_group" "non_compliant_tags" {
#   name     = "rg-noncompliant-tags"
#   location = "eastus"

#   tags = {
#     environment = "dev"
#   }
# }


# --------------------------------------------------
# Test Case 3: Compliant Resource Group
# --------------------------------------------------
# This resource group satisfies ALL
# policy requirements:
# - Allowed location
# - Mandatory tags present
#
# Expected Result:
# - Terraform apply should SUCCEED
# --------------------------------------------------

resource "azurerm_resource_group" "compliant_rg" {
  name     = "rg-compliant"
  location = "eastus"

  tags = {
    department = "devops"
    project    = "policy-governance"
  }
}
