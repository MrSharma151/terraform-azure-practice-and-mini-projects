# ------------------------------------------------------------
# Terraform backend configuration for remote state storage
# ------------------------------------------------------------
terraform {

  # Use Azure Storage Account as remote backend
  backend "azurerm" {

    # Resource group where the storage account exists
    resource_group_name  = "framely-dev"

    # Existing Azure Storage Account name
    storage_account_name = "framelystorage"

    # Blob container to store Terraform state files
    container_name       = "terraform-state-files"

    # Name of the Terraform state file
    key                  = "terraform-demo.tfstate"
  }
}
