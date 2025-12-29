# ------------------------------------------------------------
# Local values for reusable configuration
# ------------------------------------------------------------
locals {

  # Common tags applied to all resources
  common_tags = {
    environment = var.environment   # Environment tag
    owner       = "rohit"            # Resource owner
    managed_by  = "terraform"        # Management tool
  }
}
