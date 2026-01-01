# ------------------------------------------------------------
# Virtual Networks and Subnets
# This file creates two VNets, each with one subnet,
# and establishes bi-directional VNet peering.
# ------------------------------------------------------------

# ------------------------------------------------------------
# Virtual Networks
# ------------------------------------------------------------
resource "azurerm_virtual_network" "this" {

  # Create two VNets using for_each
  for_each = var.vnets

  name                = each.value.vnet_name
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name

  address_space = each.value.address_space

  tags = local.common_tags
}

# ------------------------------------------------------------
# Subnets
# ------------------------------------------------------------
resource "azurerm_subnet" "this" {

  # Create one subnet per VNet
  for_each = var.vnets

  name                 = each.value.subnet_name
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this[each.key].name

  address_prefixes = each.value.subnet_address_prefixes
}

# ------------------------------------------------------------
# VNet Peering (VNet-1 -> VNet-2)
# ------------------------------------------------------------
resource "azurerm_virtual_network_peering" "vnet1_to_vnet2" {

  name = "vnet1-to-vnet2"

  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this["vnet1"].name
  remote_virtual_network_id = azurerm_virtual_network.this["vnet2"].id

  # Allow traffic between VNets
  allow_virtual_network_access = true

  # No gateway or forwarded traffic needed for this mini project
  allow_forwarded_traffic      = false
  allow_gateway_transit        = false
  use_remote_gateways          = false
}

# ------------------------------------------------------------
# VNet Peering (VNet-2 -> VNet-1)
# ------------------------------------------------------------
resource "azurerm_virtual_network_peering" "vnet2_to_vnet1" {

  name = "vnet2-to-vnet1"

  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this["vnet2"].name
  remote_virtual_network_id = azurerm_virtual_network.this["vnet1"].id

  # Allow traffic between VNets
  allow_virtual_network_access = true

  # No gateway or forwarded traffic needed for this mini project
  allow_forwarded_traffic      = false
  allow_gateway_transit        = false
  use_remote_gateways          = false
}
