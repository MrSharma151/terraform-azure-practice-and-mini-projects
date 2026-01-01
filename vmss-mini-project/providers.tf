# ------------------------------------------------------------
# Terraform configuration block
# ------------------------------------------------------------
terraform {

  # Minimum Terraform version required to run this configuration
  required_version = ">= 1.5.0"

  # ----------------------------------------------------------
  # Required providers configuration
  # ----------------------------------------------------------
  required_providers {

    # Azure Resource Manager (azurerm) provider
    azurerm = {

      # Official provider source from HashiCorp Registry
      source  = "hashicorp/azurerm"

      # Provider version constraint
      # Locks provider to compatible minor versions
      # Helps avoid unexpected breaking changes
      version = "~> 3.100"
    }
  }

  # ----------------------------------------------------------
  # Remote backend configuration (Azure Storage Account)
  # ----------------------------------------------------------
  backend "azurerm" {

    # Resource Group containing the storage account
    resource_group_name  = "framely-dev"

    # Existing Azure Storage Account name
    storage_account_name = "framelystorage"

    # Blob container used to store Terraform state files
    container_name       = "terraform-state-files"

    # Name of the Terraform state file
    key                  = "terraform-demo.tfstate"
  }
}

# ------------------------------------------------------------
# Azure provider configuration
# ------------------------------------------------------------
provider "azurerm" {

  # The features block is mandatory for the azurerm provider
  # Even if no features are configured, it must be declared
  features {}
}
