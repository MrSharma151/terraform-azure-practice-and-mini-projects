# ------------------------------------------------------------
# Input variables for Resource Group configuration
# ------------------------------------------------------------
variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
}

variable "location" {
  description = "Azure region where all resources will be deployed"
  type        = string
}


# ------------------------------------------------------------
# Network related input variables
# ------------------------------------------------------------
variable "vnet_name" {
  description = "Name of the Azure Virtual Network"
  type        = string
}

variable "vnet_address_space" {
  description = "Address space for the Virtual Network"
  type        = list(string)
}

variable "vmss_subnet_name" {
  description = "Name of the subnet used by VM Scale Set"
  type        = string
}

variable "vmss_subnet_address_prefix" {
  description = "Address prefix for the VMSS subnet"
  type        = list(string)
}


# ------------------------------------------------------------
# Security related input variables
# ------------------------------------------------------------
variable "vmss_nsg_name" {
  description = "Name of the Network Security Group for VMSS subnet"
  type        = string
}


# ------------------------------------------------------------
# Load Balancer related input variables
# ------------------------------------------------------------
variable "lb_public_ip_name" {
  description = "Name of the Public IP for Load Balancer"
  type        = string
}

variable "lb_name" {
  description = "Name of the Azure Load Balancer"
  type        = string
}


# ------------------------------------------------------------
# VM Scale Set input variables
# ------------------------------------------------------------
variable "vmss_name" {
  description = "Name of the Virtual Machine Scale Set"
  type        = string
}

variable "vmss_sku" {
  description = "VM size for VM Scale Set instances"
  type        = string
}

variable "vmss_default_instances" {
  description = "Default number of VMSS instances"
  type        = number
}

variable "vmss_admin_username" {
  description = "Admin username for VMSS instances"
  type        = string
}

variable "ssh_public_key_path" {
  description = "Path to SSH public key"
  type        = string
}


# ------------------------------------------------------------
# Autoscaling input variables
# ------------------------------------------------------------
variable "autoscale_name" {
  description = "Name of the autoscale configuration"
  type        = string
}

variable "vmss_min_instances" {
  description = "Minimum number of VMSS instances"
  type        = number
}

variable "vmss_max_instances" {
  description = "Maximum number of VMSS instances"
  type        = number
}

variable "cpu_scale_out_threshold" {
  description = "CPU percentage threshold to scale out"
  type        = number
}

variable "cpu_scale_in_threshold" {
  description = "CPU percentage threshold to scale in"
  type        = number
}


# ------------------------------------------------------------
# NAT Gateway input variables
# ------------------------------------------------------------
variable "nat_public_ip_name" {
  description = "Name of the Public IP used by NAT Gateway"
  type        = string
}

variable "nat_gateway_name" {
  description = "Name of the Azure NAT Gateway"
  type        = string
}

