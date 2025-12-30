# # ------------------------------------------------------------
# # DATA SOURCE: EXISTING VIRTUAL NETWORK (CREATED BY NETWORK TEAM)
# # ------------------------------------------------------------

# data "azurerm_virtual_network" "central_vnet" {
#   name                = "central-vnet"                 # Existing VNet name
#   resource_group_name = "rg-networking-central"        # RG managed by networking team
# }

# # ------------------------------------------------------------
# # DATA SOURCE: EXISTING SUBNET (INSIDE CENTRAL VNET)
# # ------------------------------------------------------------

# data "azurerm_subnet" "central_subnet" {
#   name                 = "central-subnet"              # Existing subnet name
#   virtual_network_name = data.azurerm_virtual_network.central_vnet.name
#   resource_group_name  = "rg-networking-central"
# }

# # ------------------------------------------------------------
# # NETWORK INTERFACE IN DEVOPS RESOURCE GROUP
# # ------------------------------------------------------------

# resource "azurerm_network_interface" "vm_nic" {
#   name                = "nic-devops-vm"
#   location            = azurerm_resource_group.rg.location
#   resource_group_name = azurerm_resource_group.rg.name

#   ip_configuration {
#     name                          = "ipconfig1"
#     subnet_id                     = data.azurerm_subnet.central_subnet.id  # Using existing subnet
#     private_ip_address_allocation = "Dynamic"
#   }

#   tags = {
#     environment = "devops"
#     managed_by  = "terraform"
#   }
# }

# # ------------------------------------------------------------
# # LINUX VIRTUAL MACHINE (DEVOPS TEAM)
# # ------------------------------------------------------------

# resource "azurerm_linux_virtual_machine" "devops_vm" {
#   name                = "vm-devops-01"
#   location            = azurerm_resource_group.rg.location
#   resource_group_name = azurerm_resource_group.rg.name
#   size                = "Standard_DS1_v2"

#   admin_username = "devopsadmin"
#   admin_password = "Password1234!"
#   disable_password_authentication = false

#   network_interface_ids = [
#     azurerm_network_interface.vm_nic.id
#   ]

#   os_disk {
#     caching              = "ReadWrite"
#     storage_account_type = "Standard_LRS"
#   }

#   source_image_reference {
#     publisher = "Canonical"
#     offer     = "0001-com-ubuntu-server-jammy"
#     sku       = "22_04-lts"
#     version   = "latest"
#   }

#   tags = {
#     environment = "devops"
#     owner       = "devops-team"
#   }
# }
