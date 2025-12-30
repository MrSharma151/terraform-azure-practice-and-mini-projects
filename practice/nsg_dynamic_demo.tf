# # ------------------------------------------------------------
# # INPUT VARIABLES
# # ------------------------------------------------------------

# # Boolean variable to conditionally allow SSH
# variable "allow_ssh" {
#   description = "Enable or disable SSH access"
#   type        = bool
#   default     = true
# }

# # List of inbound security rules
# variable "nsg_rules" {
#   description = "List of NSG security rules"
#   type = list(object({
#     name                       = string
#     priority                   = number
#     direction                  = string
#     access                     = string
#     protocol                   = string
#     source_port_range          = string
#     destination_port_range     = string
#     source_address_prefix      = string
#     destination_address_prefix = string
#   }))
#   default = [
#     {
#       name                       = "allow-http"
#       priority                   = 100
#       direction                  = "Inbound"
#       access                     = "Allow"
#       protocol                   = "Tcp"
#       source_port_range          = "*"
#       destination_port_range     = "80"
#       source_address_prefix      = "*"
#       destination_address_prefix = "*"
#     },
#     {
#       name                       = "allow-https"
#       priority                   = 110
#       direction                  = "Inbound"
#       access                     = "Allow"
#       protocol                   = "Tcp"
#       source_port_range          = "*"
#       destination_port_range     = "443"
#       source_address_prefix      = "*"
#       destination_address_prefix = "*"
#     }
#   ]
# }

# # ------------------------------------------------------------
# # NETWORK SECURITY GROUP WITH DYNAMIC BLOCK
# # ------------------------------------------------------------

# resource "azurerm_network_security_group" "nsg" {
#   name                = "nsg-dynamic-demo"
#   location            = azurerm_resource_group.rg.location
#   resource_group_name = azurerm_resource_group.rg.name

#   # ----------------------------------------------------------
#   # Dynamic block to create multiple security rules
#   # ----------------------------------------------------------
#   dynamic "security_rule" {
#     for_each = var.nsg_rules

#     content {
#       name                       = security_rule.value.name
#       priority                   = security_rule.value.priority
#       direction                  = security_rule.value.direction
#       access                     = security_rule.value.access
#       protocol                   = security_rule.value.protocol
#       source_port_range          = security_rule.value.source_port_range
#       destination_port_range     = security_rule.value.destination_port_range
#       source_address_prefix      = security_rule.value.source_address_prefix
#       destination_address_prefix = security_rule.value.destination_address_prefix
#     }
#   }

#   # ----------------------------------------------------------
#   # Conditional expression to optionally allow SSH
#   # ----------------------------------------------------------
#   security_rule {
#     name                       = "allow-ssh"
#     priority                   = 200
#     direction                  = "Inbound"
#     access                     = var.allow_ssh ? "Allow" : "Deny"   # Conditional expression
#     protocol                   = "Tcp"
#     source_port_range          = "*"
#     destination_port_range     = "22"
#     source_address_prefix      = "*"
#     destination_address_prefix = "*"
#   }

#   tags = {
#     environment = "dev"
#     managed_by  = "terraform"
#   }
# }

# # ------------------------------------------------------------
# # OUTPUTS USING SPLAT EXPRESSIONS
# # ------------------------------------------------------------

# # Output all security rule names using splat expression
# output "nsg_rule_names" {
#   description = "All NSG rule names"
#   value       = azurerm_network_security_group.nsg.security_rule[*].name
# }

# # Output all destination ports using splat expression
# output "nsg_destination_ports" {
#   description = "All destination ports configured in NSG"
#   value       = azurerm_network_security_group.nsg.security_rule[*].destination_port_range
# }
