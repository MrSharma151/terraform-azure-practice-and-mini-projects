# ------------------------------------------------------------
# Local values
# Used for consistent tagging across all resources
# ------------------------------------------------------------

locals {

  # Common tags applied to every resource
  common_tags = {
    project     = "vnet-peering-mini-project"
    environment = var.environment
    managed_by  = "terraform"
  }
}
