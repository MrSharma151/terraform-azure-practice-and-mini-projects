# ------------------------------------------------------------
# Virtual Machine Scale Set
# This VMSS hosts Apache web servers behind the Load Balancer.
# ------------------------------------------------------------
resource "azurerm_linux_virtual_machine_scale_set" "this" {

  # Name of the VM Scale Set
  name = var.vmss_name

  location            = var.location
  resource_group_name = azurerm_resource_group.this.name

  # VM instance configuration
  sku       = var.vmss_sku
  instances = var.vmss_default_instances

  admin_username = var.vmss_admin_username

  # Disable password authentication for security
  disable_password_authentication = true

  # SSH public key for admin access
  admin_ssh_key {
    username   = var.vmss_admin_username
    public_key = file(var.ssh_public_key_path)
  }

  # ----------------------------------------------------------
  # OS Disk configuration
  # ----------------------------------------------------------
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  # ----------------------------------------------------------
  # Source image reference (Ubuntu LTS)
  # ----------------------------------------------------------
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  # ----------------------------------------------------------
  # Network configuration
  # ----------------------------------------------------------
  network_interface {
    name    = "vmss-nic"
    primary = true

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = azurerm_subnet.vmss.id

      # Attach VMSS to Load Balancer backend pool
      load_balancer_backend_address_pool_ids = [
        azurerm_lb_backend_address_pool.vmss.id
      ]

      # ------------------------------------------------------
      # TEMPORARY PUBLIC IP (DEBUG PURPOSE ONLY)
      # This proves Apache + VM networking is working
      # ------------------------------------------------------
    #   public_ip_address {
    #     name = "vmss-debug-pip"
    #   } --- IGNORE ---
    }
  }

  # ----------------------------------------------------------
  # Startup script (cloud-init)
  # ----------------------------------------------------------
  custom_data = base64encode(
    file("${path.module}/scripts/startup.sh")
  )

  # ----------------------------------------------------------
  # Upgrade policy
  # ----------------------------------------------------------
  upgrade_mode = "Automatic"

  # ----------------------------------------------------------
  # Tags
  # ----------------------------------------------------------
  tags = local.common_tags
}
