# ------------------------------------------------------------
# Local values
# ------------------------------------------------------------
locals {

  # Common tags applied to all resources
  # Centralized tagging avoids repetition and improves consistency
  common_tags = {
    project     = "vmss-mini-project"
    environment = "dev"
    managed_by  = "terraform"
  }
}


# ------------------------------------------------------------
# Load Balancer local values
# ------------------------------------------------------------
locals {

  # Frontend configuration name for the Load Balancer
  lb_frontend_name = "lb-frontend-public"

  # Backend pool name for VMSS
  lb_backend_pool_name = "lb-backend-vmss"
}
