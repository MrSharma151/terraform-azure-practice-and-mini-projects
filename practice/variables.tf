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
# Input variable for storage account name
# ------------------------------------------------------------
variable "storage_account_name" {
  description = "Globally unique name of the storage account"
  type        = string
  default     = "tfstoragerohit015"
}

# ------------------------------------------------------------
# Input variable for environment
# ------------------------------------------------------------
variable "environment" {
  description = "Environment name (dev, test, prod)"
  type        = string
  default     = "stagging"
}

# ------------------------------------------------------------
# String type variable
# ------------------------------------------------------------
variable "vm_prefix" {
  description = "Prefix used for naming Azure VM resources"
  type        = string
  default     = "tfvmex"
}

# ------------------------------------------------------------
# Number type variable
# ------------------------------------------------------------
variable "os_disk_size_gb" {
  description = "Size of the OS disk in GB"
  type        = number
  default     = 30
}

# ------------------------------------------------------------
# Boolean type variable
# ------------------------------------------------------------
variable "enable_password_auth" {
  description = "Enable or disable password authentication"
  type        = bool
  default     = true
}

# ------------------------------------------------------------
# List type variable
# ------------------------------------------------------------
variable "vnet_address_space" {
  description = "Address space for the virtual network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

# ------------------------------------------------------------
# Set type variable
# ------------------------------------------------------------
variable "allowed_locations" {
  description = "Allowed Azure regions"
  type        = set(string)
  default     = ["Central India", "West Europe"]
}

# ------------------------------------------------------------
# Map type variable
# ------------------------------------------------------------
variable "common_tags" {
  description = "Common tags applied to all resources"
  type        = map(string)
  default = {
    environment = "staging"
    owner       = "rohit"
    managed_by  = "terraform"
  }
}

# ------------------------------------------------------------
# Object type variable
# ------------------------------------------------------------
variable "admin_credentials" {
  description = "Admin credentials for the virtual machine"
  type = object({
    username = string
    password = string
  })
  default = {
    username = "testadmin"
    password = "Password1234!"
  }
}

# ------------------------------------------------------------
# Tuple type variable
# ------------------------------------------------------------
variable "subnet_config" {
  description = "Subnet name and CIDR block"
  type        = tuple([string, string])
  default     = ["internal", "10.0.2.0/24"]
}
