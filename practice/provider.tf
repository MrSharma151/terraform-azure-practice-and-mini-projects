# ------------------------------------------------------------
# Terraform configuration block
# ------------------------------------------------------------
terraform {

  # Minimum Terraform version required to run this configuration
  required_version = ">= 1.5.0"

  # Required providers block
  required_providers {

    # Azure Resource Manager (azurerm) provider
    azurerm = {

      # Official provider source from HashiCorp registry
      source = "hashicorp/azurerm"

      # Provider version constraint
      # This helps avoid unexpected breaking changes
      version = "~> 3.100"
    }
  }
}

# ------------------------------------------------------------
# Azure provider configuration
# ------------------------------------------------------------
provider "azurerm" {

  # The features block is mandatory for azurerm provider
  # Even if no features are configured, it must be present
  features {}
}
