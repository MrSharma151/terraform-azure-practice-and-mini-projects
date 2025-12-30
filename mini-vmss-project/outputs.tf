# ------------------------------------------------------------
# Output values
# These outputs expose important infrastructure information
# after Terraform apply.
# ------------------------------------------------------------

# ------------------------------------------------------------
# Resource Group details
# ------------------------------------------------------------
output "resource_group_name" {

  description = "Name of the Azure Resource Group"
  value       = azurerm_resource_group.this.name
}

output "resource_group_location" {

  description = "Azure region where resources are deployed"
  value       = azurerm_resource_group.this.location
}

# ------------------------------------------------------------
# Networking details
# ------------------------------------------------------------
output "virtual_network_name" {

  description = "Name of the Virtual Network"
  value       = azurerm_virtual_network.this.name
}

output "vmss_subnet_name" {

  description = "Name of the subnet used by VM Scale Set"
  value       = azurerm_subnet.vmss.name
}

output "vmss_subnet_address_prefixes" {

  description = "Address prefixes of the VMSS subnet"
  value       = azurerm_subnet.vmss.address_prefixes
}

# ------------------------------------------------------------
# Load Balancer details
# ------------------------------------------------------------
output "load_balancer_name" {

  description = "Name of the Azure Load Balancer"
  value       = azurerm_lb.this.name
}

output "load_balancer_public_ip" {

  description = "Public IP address of the Load Balancer (application entry point)"
  value       = azurerm_public_ip.lb.ip_address
}

# ------------------------------------------------------------
# VM Scale Set details
# ------------------------------------------------------------
output "vmss_name" {

  description = "Name of the Virtual Machine Scale Set"
  value       = azurerm_linux_virtual_machine_scale_set.this.name
}

output "vmss_instance_count" {

  description = "Current default number of VMSS instances"
  value       = azurerm_linux_virtual_machine_scale_set.this.instances
}

output "vmss_sku" {

  description = "VM size used by the VM Scale Set"
  value       = azurerm_linux_virtual_machine_scale_set.this.sku
}

# ------------------------------------------------------------
# Autoscaling details
# ------------------------------------------------------------
output "autoscale_setting_name" {

  description = "Name of the autoscale configuration applied to VMSS"
  value       = azurerm_monitor_autoscale_setting.vmss.name
}

# ------------------------------------------------------------
# NAT Gateway details
# ------------------------------------------------------------
output "nat_gateway_name" {

  description = "Name of the NAT Gateway used for outbound internet access"
  value       = azurerm_nat_gateway.this.name
}

output "nat_public_ip" {

  description = "Public IP address used by NAT Gateway for outbound traffic"
  value       = azurerm_public_ip.nat.ip_address
  sensitive = true
}

# ------------------------------------------------------------
# Security details
# ------------------------------------------------------------
output "vmss_nsg_name" {

  description = "Name of the Network Security Group applied to VMSS subnet"
  value       = azurerm_network_security_group.vmss.name
}
