# ------------------------------------------------------------
# Autoscale configuration for VM Scale Set
# This enables automatic scaling based on CPU utilization.
# ------------------------------------------------------------
resource "azurerm_monitor_autoscale_setting" "vmss" {

  # Name of the autoscale setting
  name = var.autoscale_name

  # Location is mandatory for autoscale settings
  # Must match the location of the target resource
  location = var.location

  # Resource Group where autoscale configuration exists
  resource_group_name = azurerm_resource_group.this.name

  # Target VM Scale Set to apply autoscaling
  target_resource_id = azurerm_linux_virtual_machine_scale_set.this.id

  # ----------------------------------------------------------
  # Autoscale Profile
  # ----------------------------------------------------------
  profile {
    name = "cpu-based-autoscaling"

    # Capacity limits
    capacity {
      minimum = var.vmss_min_instances
      default = var.vmss_default_instances
      maximum = var.vmss_max_instances
    }

    # --------------------------------------------------------
    # Scale OUT rule (Increase VM instances)
    # Triggered when average CPU > threshold
    # --------------------------------------------------------
    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.this.id

        time_grain = "PT1M"
        statistic  = "Average"
        time_window = "PT5M"

        time_aggregation = "Average"
        operator          = "GreaterThan"
        threshold         = var.cpu_scale_out_threshold
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT5M"
      }
    }

    # --------------------------------------------------------
    # Scale IN rule (Decrease VM instances)
    # Triggered when average CPU < threshold
    # --------------------------------------------------------
    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.this.id

        time_grain = "PT1M"
        statistic  = "Average"
        time_window = "PT10M"

        time_aggregation = "Average"
        operator          = "LessThan"
        threshold         = var.cpu_scale_in_threshold
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT10M"
      }
    }
  }

  # ----------------------------------------------------------
  # Common tags
  # ----------------------------------------------------------
  tags = local.common_tags
}
