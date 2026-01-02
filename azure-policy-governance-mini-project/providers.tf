# -------------------------------------------
# providers.tf
# -------------------------------------------
# This file defines:
# - Terraform version constraints
# - Required providers and their versions
# - Azure provider configuration
#
# NOTE:
# - We are using the default LOCAL backend
# - Remote backend is intentionally skipped
#   as this is a governance lab project
# -------------------------------------------

terraform {
  # Minimum Terraform version required
  required_version = ">= 1.5.0"

  # Required providers for this project
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

# Azure Provider configuration
# Authentication is picked automatically from:
# - az login
# - Environment variables (ARM_*)
provider "azurerm" {
  features {}
}
