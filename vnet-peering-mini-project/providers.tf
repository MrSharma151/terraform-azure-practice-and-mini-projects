# ------------------------------------------------------------
# Terraform configuration
# ------------------------------------------------------------
terraform {

  # Minimum Terraform version required
  required_version = ">= 1.5.0"

  # ----------------------------------------------------------
  # Required providers
  # ----------------------------------------------------------
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.100"
    }
  }

  # ----------------------------------------------------------
  # Remote backend configuration (Azure Storage Account)
  # ----------------------------------------------------------
  backend "azurerm" {

    # Resource Group containing the storage account
    resource_group_name = "framely-dev"

    # Existing Azure Storage Account name
    storage_account_name = "framelystorage"

    # Blob container used to store Terraform state files
    container_name = "terraform-state-files"

    # State file name for VNet peering mini project
    key = "vnet-peering-mini-project.tfstate"
  }
}

# ------------------------------------------------------------
# Azure Provider configuration
# ------------------------------------------------------------
provider "azurerm" {

  # The features block is mandatory for the azurerm provider
  features {}
}
