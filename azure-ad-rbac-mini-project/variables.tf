# ------------------------------------------------------------
# Global / Common variables
# ------------------------------------------------------------

variable "location" {
  description = "Azure region where the Resource Group exists"
  type        = string
}

variable "environment" {
  description = "Environment name (dev, test, prod)"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the Resource Group used as RBAC scope"
  type        = string
}

variable "tenant_domain" {
  description = "Azure AD Tenant Domain (e.g. example.onmicrosoft.com)"
  type        = string

  validation {
    condition     = can(regex("\\.onmicrosoft\\.com$", var.tenant_domain))
    error_message = "tenant_domain must end with '.onmicrosoft.com'"
  }
}

# ------------------------------------------------------------
# Azure AD Users configuration
# ------------------------------------------------------------
variable "users" {
  description = "Map of Azure AD users to be created"

  type = map(object({
    first_name = string
    last_name  = string
    password   = string
  }))

}

# ------------------------------------------------------------
# Azure AD Groups configuration
# ------------------------------------------------------------
variable "groups" {
  description = "Map of Azure AD security groups"

  type = map(object({
    display_name = string
    description  = string
  }))
}

# ------------------------------------------------------------
# Group membership mapping
# ------------------------------------------------------------
variable "group_membership" {
  description = "Mapping of Azure AD groups to their member users"

  type = map(object({
    users = list(string)
  }))
}
