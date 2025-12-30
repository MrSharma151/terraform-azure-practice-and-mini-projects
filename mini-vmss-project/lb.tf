# ------------------------------------------------------------
# Public IP
# This Public IP acts as the single internet entry point.
# It will be attached to the Load Balancer frontend.
# ------------------------------------------------------------
resource "azurerm_public_ip" "lb" {

  # Name of the Public IP resource
  name = var.lb_public_ip_name

  # Azure region and resource group
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name

  # Static allocation is recommended for Load Balancers
  allocation_method = "Static"

  # SKU must be Standard for VMSS + Standard Load Balancer
  sku = "Standard"

  # Common tags
  tags = local.common_tags
}

# ------------------------------------------------------------
# Load Balancer
# This Load Balancer distributes traffic to VMSS instances.
# ------------------------------------------------------------
resource "azurerm_lb" "this" {

  # Name of the Load Balancer
  name = var.lb_name

  location            = var.location
  resource_group_name = azurerm_resource_group.this.name

  # Standard SKU is required for VMSS integration
  sku = "Standard"

  # Frontend IP configuration using Public IP
  frontend_ip_configuration {
    name                 = local.lb_frontend_name
    public_ip_address_id = azurerm_public_ip.lb.id
  }

  tags = local.common_tags
}

# ------------------------------------------------------------
# Backend Address Pool
# VMSS instances will be attached to this backend pool.
# ------------------------------------------------------------
resource "azurerm_lb_backend_address_pool" "vmss" {

  name            = local.lb_backend_pool_name
  loadbalancer_id = azurerm_lb.this.id
}

# ------------------------------------------------------------
# Health Probe
# Used by the Load Balancer to check VM instance health.
# ------------------------------------------------------------
resource "azurerm_lb_probe" "http" {

  name            = "http-health-probe"
  loadbalancer_id = azurerm_lb.this.id

#   protocol = "Http"
  protocol = "Tcp"
  port     = 80
#   request_path = "/"

  interval_in_seconds = 5
  number_of_probes    = 2
}

# ------------------------------------------------------------
# Load Balancer Rule
# Routes incoming HTTP traffic to backend VMSS instances.
# ------------------------------------------------------------
resource "azurerm_lb_rule" "http" {

  name = "http-rule"

  loadbalancer_id = azurerm_lb.this.id

  protocol = "Tcp"

  frontend_port = 80
  backend_port  = 80

  frontend_ip_configuration_name = local.lb_frontend_name
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.vmss.id]
  probe_id                       = azurerm_lb_probe.http.id
}
