# # ------------------------------------------------------------
# # Public IP resource to demonstrate lifecycle meta-arguments
# # ------------------------------------------------------------
# resource "azurerm_public_ip" "lifecycle_demo" {

#   # Name of the public IP resource
#   name = "pip-lifecycle-demo"

#   # Azure region (reusing existing resource group)
#   location = azurerm_resource_group.rg.location

#   # Resource group reference
#   resource_group_name = azurerm_resource_group.rg.name

#   # Allocation method for public IP
#   allocation_method = "Static"

#   # SKU of the public IP
#   sku = "Standard"

#   # Tags applied to the resource
#   tags = {
#     environment = "dev"
#     owner       = "rohit"
#   }

#   # ------------------------------------------------------------
#   # Lifecycle meta-arguments
#   # ------------------------------------------------------------
#   lifecycle {

#     # --------------------------------------------------------
#     # create_before_destroy
#     # --------------------------------------------------------
#     # Ensures the new resource is created first
#     # before the old one is destroyed
#     # Useful when resource replacement may cause downtime
#     create_before_destroy = true

#     # --------------------------------------------------------
#     # prevent_destroy
#     # --------------------------------------------------------
#     # Prevents accidental deletion of this resource
#     # Terraform will throw an error if destroy is attempted
#     # Comment this out when you actually want to destroy
#     prevent_destroy = false

#     # --------------------------------------------------------
#     # ignore_changes
#     # --------------------------------------------------------
#     # Tells Terraform to ignore changes to specific attributes
#     # Even if the value changes, Terraform will not update it
#     ignore_changes = [
#       tags["owner"]
#     ]

#     # --------------------------------------------------------
#     # replace_triggered_by
#     # --------------------------------------------------------
#     # Forces resource replacement when another resource changes
#     # Example: if resource group name changes, this public IP is replaced
#     replace_triggered_by = [
#       azurerm_resource_group.rg.name
#     ]

#     # --------------------------------------------------------
#     # custom precondition
#     # --------------------------------------------------------
#     # Validates conditions before resource creation
#     precondition {
#       condition     = lower(azurerm_resource_group.rg.location) == "centralindia"
#       error_message = "Public IP can only be created in Central India region."
#     }

#     # --------------------------------------------------------
#     # custom postcondition
#     # --------------------------------------------------------
#     # Validates resource state after creation
#     postcondition {
#       condition     = self.allocation_method == "Static"
#       error_message = "Public IP must use Static allocation."
#     }
#   }
# }
