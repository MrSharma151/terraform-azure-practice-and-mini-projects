# ------------------------------------------------------------
# Network Security Group
# Allows SSH and ICMP within VNets (for Bastion & testing)
# ------------------------------------------------------------
resource "azurerm_network_security_group" "this" {

  name                = "nsg-vnet-peering-vms"
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name

  # Allow SSH (used by Bastion)
  security_rule {
    name                       = "allow-ssh"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  # Allow ICMP for connectivity testing (ping)
  security_rule {
    name                       = "allow-icmp"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Icmp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = local.common_tags
}

# ------------------------------------------------------------
# Associate NSG with both subnets
# ------------------------------------------------------------
resource "azurerm_subnet_network_security_group_association" "this" {

  for_each = var.vnets

  subnet_id                 = azurerm_subnet.this[each.key].id
  network_security_group_id = azurerm_network_security_group.this.id
}

# ------------------------------------------------------------
# Network Interfaces (no public IP)
# ------------------------------------------------------------
resource "azurerm_network_interface" "this" {

  for_each = var.vnets

  name                = "nic-${each.key}"
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.this[each.key].id
    private_ip_address_allocation = "Dynamic"
  }

  tags = local.common_tags
}

# ------------------------------------------------------------
# Linux Virtual Machines (private access only)
# ------------------------------------------------------------
resource "azurerm_linux_virtual_machine" "this" {

  for_each = var.vnets

  name                = "vm-${each.key}"
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name
  size                = var.vm_size

  admin_username = var.vm_admin_username

  disable_password_authentication = true

  network_interface_ids = [
    azurerm_network_interface.this[each.key].id
  ]

  # SSH key authentication (used via Bastion)
  admin_ssh_key {
    username   = var.vm_admin_username
    public_key = file(var.ssh_public_key_path)
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  tags = local.common_tags
}

# ------------------------------------------------------------
# Azure Bastion Subnet (MANDATORY name)
# ------------------------------------------------------------
resource "azurerm_subnet" "bastion" {

  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this["vnet1"].name

  address_prefixes = ["10.10.255.0/27"]
}

# ------------------------------------------------------------
# Public IP for Bastion
# ------------------------------------------------------------
resource "azurerm_public_ip" "bastion" {

  name                = "pip-bastion"
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name

  allocation_method = "Static"
  sku               = "Standard"

  tags = local.common_tags
}

# ------------------------------------------------------------
# Azure Bastion Host
# ------------------------------------------------------------
resource "azurerm_bastion_host" "this" {

  name                = "bastion-vnet-peering"
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name

  ip_configuration {
    name                 = "bastion-ip-config"
    subnet_id            = azurerm_subnet.bastion.id
    public_ip_address_id = azurerm_public_ip.bastion.id
  }

  tags = local.common_tags
}
