# ------------------------------------------------------------
# Public IP for NAT Gateway
# This Public IP is used only for outbound internet traffic.
# ------------------------------------------------------------
resource "azurerm_public_ip" "nat" {

  # Name of the NAT Public IP
  name = var.nat_public_ip_name

  location            = var.location
  resource_group_name = azurerm_resource_group.this.name

  # Static allocation is mandatory for NAT Gateway
  allocation_method = "Static"

  # NAT Gateway requires Standard SKU Public IP
  sku = "Standard"

  # Common tags
  tags = local.common_tags
}

# ------------------------------------------------------------
# NAT Gateway
# Provides outbound internet access for private subnet resources
# ------------------------------------------------------------
resource "azurerm_nat_gateway" "this" {

  # Name of the NAT Gateway
  name = var.nat_gateway_name

  location            = var.location
  resource_group_name = azurerm_resource_group.this.name

  # Idle timeout for outbound connections (minutes)
  idle_timeout_in_minutes = 10

  tags = local.common_tags
}

# ------------------------------------------------------------
# Associate Public IP with NAT Gateway
# ------------------------------------------------------------
resource "azurerm_nat_gateway_public_ip_association" "this" {

  nat_gateway_id       = azurerm_nat_gateway.this.id
  public_ip_address_id = azurerm_public_ip.nat.id
}

# ------------------------------------------------------------
# Associate NAT Gateway with VMSS Subnet
# ------------------------------------------------------------
resource "azurerm_subnet_nat_gateway_association" "vmss" {

  # Subnet where VM Scale Set is deployed
  subnet_id = azurerm_subnet.vmss.id

  # NAT Gateway providing outbound access
  nat_gateway_id = azurerm_nat_gateway.this.id
}
