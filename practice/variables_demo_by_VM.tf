# # ------------------------------------------------------------
# # Virtual Network
# # ------------------------------------------------------------
# resource "azurerm_virtual_network" "vnet" {
#   name                = "${var.vm_prefix}-vnet"              # String variable usage
#   address_space       = var.vnet_address_space               # List variable usage
#   location            = azurerm_resource_group.rg.location
#   resource_group_name = azurerm_resource_group.rg.name
#   tags                = var.common_tags                      # Map variable usage
# }

# # ------------------------------------------------------------
# # Subnet
# # ------------------------------------------------------------
# resource "azurerm_subnet" "subnet" {
#   name                 = var.subnet_config[0]                # Tuple index usage
#   resource_group_name  = azurerm_resource_group.rg.name
#   virtual_network_name = azurerm_virtual_network.vnet.name
#   address_prefixes     = [var.subnet_config[1]]              # Tuple index usage
# }

# # ------------------------------------------------------------
# # Network Interface
# # ------------------------------------------------------------
# resource "azurerm_network_interface" "nic" {
#   name                = "${var.vm_prefix}-nic"
#   location            = azurerm_resource_group.rg.location
#   resource_group_name = azurerm_resource_group.rg.name

#   ip_configuration {
#     name                          = "ipconfig1"
#     subnet_id                     = azurerm_subnet.subnet.id
#     private_ip_address_allocation = "Dynamic"
#   }

#   tags = var.common_tags
# }

# # ------------------------------------------------------------
# # Linux Virtual Machine
# # ------------------------------------------------------------
# resource "azurerm_linux_virtual_machine" "vm" {
#   name                = "${var.vm_prefix}-vm"
#   location            = azurerm_resource_group.rg.location
#   resource_group_name = azurerm_resource_group.rg.name
#   size                = "Standard_DS1_v2"

#   admin_username = var.admin_credentials.username            # Object variable usage
#   admin_password = var.admin_credentials.password            # Object variable usage

#   disable_password_authentication = !var.enable_password_auth # Boolean variable usage

#   network_interface_ids = [
#     azurerm_network_interface.nic.id
#   ]

#   os_disk {
#     caching              = "ReadWrite"
#     storage_account_type = "Standard_LRS"
#     disk_size_gb         = var.os_disk_size_gb                # Number variable usage
#   }

#   source_image_reference {
#     publisher = "Canonical"
#     offer     = "0001-com-ubuntu-server-jammy"
#     sku       = "22_04-lts"
#     version   = "latest"
#   }

#   tags = var.common_tags
# }
