# ------------------------------------------------------------
# Network Security Group (NSG)
# This NSG controls traffic for the VMSS subnet.
# Direct public access to VM instances is restricted.
# ------------------------------------------------------------

resource "azurerm_network_security_group" "vmss" {

  # Name of the Network Security Group
  name = var.vmss_nsg_name

  # Location and Resource Group are inherited from base configuration
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name

  # Common tags for consistency
  tags = local.common_tags
}

# ------------------------------------------------------------
# NSG Rule: Allow HTTP traffic from Azure Load Balancer only
# ------------------------------------------------------------
resource "azurerm_network_security_rule" "allow_http_from_lb" {

  name = "allow-http-from-loadbalancer"

  # Priority should be lower number for higher precedence
  priority = 100

  direction = "Inbound"
  access    = "Allow"
  protocol  = "Tcp"

  # Source is Azure Load Balancer service tag
  source_address_prefix = "AzureLoadBalancer"

  source_port_range = "*"

  # Destination is VMSS subnet instances
  destination_address_prefix = "*"
  destination_port_range     = 80

  resource_group_name         = azurerm_resource_group.this.name
  network_security_group_name = azurerm_network_security_group.vmss.name
}

# ------------------------------------------------------------
# NSG Rule: Deny all inbound traffic from Internet
# ------------------------------------------------------------
resource "azurerm_network_security_rule" "deny_all_inbound" {

  name = "deny-all-inbound-internet"

  priority = 4096

  direction = "Inbound"
  access    = "Deny"
  protocol  = "*"

  # Internet represents all public traffic
  source_address_prefix = "Internet"
  source_port_range     = "*"

  destination_address_prefix = "*"
  destination_port_range     = "*"

  resource_group_name         = azurerm_resource_group.this.name
  network_security_group_name = azurerm_network_security_group.vmss.name
}

# ------------------------------------------------------------
# Associate NSG with VMSS Subnet
# ------------------------------------------------------------
resource "azurerm_subnet_network_security_group_association" "vmss" {

  # Subnet where VM Scale Set is deployed
  subnet_id = azurerm_subnet.vmss.id

  # NSG applied to the subnet
  network_security_group_id = azurerm_network_security_group.vmss.id
}
