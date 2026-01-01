# ------------------------------------------------------------
# Common input variables for VNet Peering mini project
# ------------------------------------------------------------

# ------------------------------------------------------------
# Resource Group name
# ------------------------------------------------------------
variable "resource_group_name" {
  description = "Name of the Azure Resource Group where all resources will be created"
  type        = string
}

# ------------------------------------------------------------
# Azure region
# ------------------------------------------------------------
variable "location" {
  description = "Azure region for deploying resources"
  type        = string
}

# ------------------------------------------------------------
# Environment name (used for tagging)
# ------------------------------------------------------------
variable "environment" {
  description = "Deployment environment name (e.g., dev, test, prod)"
  type        = string
}

# ------------------------------------------------------------
# Virtual Networks configuration
# This map defines VNets and their respective subnets
# ------------------------------------------------------------
variable "vnets" {
  description = "Map of virtual networks and their subnet configurations"
  type = map(object({
    vnet_name                = string
    address_space            = list(string)
    subnet_name              = string
    subnet_address_prefixes  = list(string)
  }))
}

# ------------------------------------------------------------
# VM configuration variables
# ------------------------------------------------------------
variable "vm_size" {
  type        = string
  description = "Size of the Linux virtual machines"
}

variable "vm_admin_username" {
  type        = string
  description = "Admin username for Linux VMs"
}

variable "ssh_public_key_path" {
  type        = string
  description = "Path to SSH public key"
}
