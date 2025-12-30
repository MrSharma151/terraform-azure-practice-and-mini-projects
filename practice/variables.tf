# ------------------------------------------------------------
# Input variable for resource group name
# ------------------------------------------------------------
variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
  default     = "rg-terraform-demo1"
}

# ------------------------------------------------------------
# Input variable for Azure region
# ------------------------------------------------------------
variable "location" {
  description = "Azure region where resources will be created"
  type        = string
  default     = "Central India"
}

# ------------------------------------------------------------
# Input variable for environment
# ------------------------------------------------------------
variable "environment" {
  description = "Environment name (dev, test, prod)"
  type        = string
  default     = "stagging"
}

# # ------------------------------------------------------------
# # VARIABLES FOR CREATING STORAGE ACCOUNTS - storage_account.tf
# # ------------------------------------------------------------

# # ------------------------------------------------------------
# # Variable for creating multiple storage accounts using count
# # ------------------------------------------------------------
# variable "storage_account_names_count" {
#   description = "List of storage account names for count meta-argument"
#   type        = list(string)
#   default     = [
#     "tfcountstorage01",
#     "tfcountstorage02"
#   ]
# }

# # ------------------------------------------------------------
# # Variable for creating storage accounts using for_each
# # ------------------------------------------------------------
# variable "storage_accounts_map" {
#   description = "Map of storage accounts for for_each meta-argument"
#   type        = map(string)
#   default = {
#     sa1 = "tfeachstorage01"
#     sa2 = "tfeachstorage02"
#   }
# }


# # ------------------------------------------------------------
# # VARIABLES FOR CREATING VM - vm.tf
# # ------------------------------------------------------------

# # ------------------------------------------------------------
# # String type variable
# # ------------------------------------------------------------
# variable "vm_prefix" {
#   description = "Prefix used for naming Azure VM resources"
#   type        = string
#   default     = "tfvmex"
# }

# # ------------------------------------------------------------
# # Number type variable
# # ------------------------------------------------------------
# variable "os_disk_size_gb" {
#   description = "Size of the OS disk in GB"
#   type        = number
#   default     = 30
# }

# # ------------------------------------------------------------
# # Boolean type variable
# # ------------------------------------------------------------
# variable "enable_password_auth" {
#   description = "Enable or disable password authentication"
#   type        = bool
#   default     = true
# }

# # ------------------------------------------------------------
# # List type variable
# # ------------------------------------------------------------
# variable "vnet_address_space" {
#   description = "Address space for the virtual network"
#   type        = list(string)
#   default     = ["10.0.0.0/16"]
# }

# # ------------------------------------------------------------
# # Set type variable
# # ------------------------------------------------------------
# variable "allowed_locations" {
#   description = "Allowed Azure regions"
#   type        = set(string)
#   default     = ["Central India", "West Europe"]
# }

# # ------------------------------------------------------------
# # Map type variable
# # ------------------------------------------------------------
# variable "common_tags" {
#   description = "Common tags applied to all resources"
#   type        = map(string)
#   default = {
#     environment = "staging"
#     owner       = "rohit"
#     managed_by  = "terraform"
#   }
# }

# # ------------------------------------------------------------
# # Object type variable
# # ------------------------------------------------------------
# variable "admin_credentials" {
#   description = "Admin credentials for the virtual machine"
#   type = object({
#     username = string
#     password = string
#   })
#   default = {
#     username = "testadmin"
#     password = "Password1234!"
#   }
# }

# # ------------------------------------------------------------
# # Tuple type variable
# # ------------------------------------------------------------
# variable "subnet_config" {
#   description = "Subnet name and CIDR block"
#   type        = tuple([string, string])
#   default     = ["internal", "10.0.2.0/24"]
# }
