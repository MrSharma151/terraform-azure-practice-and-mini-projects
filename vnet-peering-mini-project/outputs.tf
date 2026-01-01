# ------------------------------------------------------------
# Resource Group outputs
# ------------------------------------------------------------
output "resource_group_name" {
  description = "Name of the resource group"
  value       = azurerm_resource_group.this.name
}

output "location" {
  description = "Azure region where resources are deployed"
  value       = azurerm_resource_group.this.location
}

# ------------------------------------------------------------
# Virtual Network outputs
# ------------------------------------------------------------
output "virtual_networks" {
  description = "List of virtual networks created"
  value = {
    for k, v in azurerm_virtual_network.this :
    k => v.name
  }
}

output "subnets" {
  description = "Subnet names and CIDR ranges"
  value = {
    for k, s in azurerm_subnet.this :
    k => {
      name   = s.name
      cidr   = s.address_prefixes
    }
  }
}

# ------------------------------------------------------------
# Virtual Machine outputs
# ------------------------------------------------------------
output "virtual_machines" {
  description = "VM names and their private IP addresses"
  value = {
    for k, vm in azurerm_linux_virtual_machine.this :
    k => {
      name       = vm.name
      private_ip = azurerm_network_interface.this[k].ip_configuration[0].private_ip_address
    }
  }
}

# ------------------------------------------------------------
# Bastion outputs
# ------------------------------------------------------------
output "bastion_name" {
  description = "Azure Bastion Host name"
  value       = azurerm_bastion_host.this.name
}

output "bastion_public_ip" {
  description = "Public IP address of Bastion host"
  value       = azurerm_public_ip.bastion.ip_address
}
