# ------------------------------------------------------------
# Terraform configuration block
# ------------------------------------------------------------
terraform {

  # Minimum Terraform version
  required_version = ">= 1.5.0"

  # ----------------------------------------------------------
  # Required providers
  # ----------------------------------------------------------
  required_providers {

    # Azure Active Directory provider
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.50"
    }

    # Azure Resource Manager provider
    # Used ONLY for:
    # - Remote backend (Azure Storage)
    # - RBAC role assignments
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
    resource_group_name  = "framely-dev"

    # Existing Azure Storage Account name
    storage_account_name = "framelystorage"

    # Blob container used to store Terraform state files
    container_name       = "terraform-state-files"

    # State file name (unique for this project)
    key                  = "azure-ad-rbac-mini-project.tfstate"

    # Use Azure AD authentication for backend access
    use_azuread_auth = true
  }
}

# ------------------------------------------------------------
# Azure AD provider configuration
# Authentication happens via Service Principal environment variables
# ------------------------------------------------------------
provider "azuread" {
  # No explicit configuration required
}

# ------------------------------------------------------------
# Azure Resource Manager provider
# Required for RBAC role assignments and backend access
# ------------------------------------------------------------
provider "azurerm" {

  # Features block is mandatory
  features {}
}
