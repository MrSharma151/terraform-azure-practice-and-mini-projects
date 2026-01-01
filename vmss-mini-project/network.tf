# ------------------------------------------------------------
# Virtual Network and Subnet configuration
# ------------------------------------------------------------

# ------------------------------------------------------------
# Virtual Network
# This VNet acts as a private network boundary for all resources.
# ------------------------------------------------------------
resource "azurerm_virtual_network" "this" {

  # Name of the Virtual Network
  name = var.vnet_name

  # Azure region (same as Resource Group)
  location = var.location

  # Resource Group where the VNet will be created
  resource_group_name = azurerm_resource_group.this.name

  # Address space for the Virtual Network
  address_space = var.vnet_address_space

  # Common tags applied using locals
  tags = local.common_tags
}

# ------------------------------------------------------------
# Subnet for VM Scale Set
# This subnet will host VMSS and related backend resources.
# ------------------------------------------------------------
resource "azurerm_subnet" "vmss" {

  # Name of the subnet
  name = var.vmss_subnet_name

  # Resource Group name
  resource_group_name = azurerm_resource_group.this.name

  # Virtual Network to which this subnet belongs
  virtual_network_name = azurerm_virtual_network.this.name

  # Address prefix for the subnet
  address_prefixes = var.vmss_subnet_address_prefix
}
