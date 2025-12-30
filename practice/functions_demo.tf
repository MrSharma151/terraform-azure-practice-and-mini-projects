# # ------------------------------------------------------------
# # INPUT VARIABLES
# # ------------------------------------------------------------

# variable "env_name" {
#   description = "Environment name"
#   type        = string
#   default     = " Dev "
# }

# variable "numbers" {
#   description = "List of numbers for math functions"
#   type        = list(number)
#   default     = [-5, 3, 10]
#   nullable    = false
# }

# variable "tags_map" {
#   description = "Map for merge and lookup functions"
#   type        = map(string)
#   default = {
#     owner = "rohit"
#   }
# }

# variable "ports_csv" {
#   description = "Comma separated ports"
#   type        = string
#   default     = "80,443,22"
# }

# # ------------------------------------------------------------
# # LOCALS – FUNCTIONS DEMONSTRATION
# # ------------------------------------------------------------

# locals {

#   # -------------------------
#   # Easy functions
#   # -------------------------

#   env_lower   = lower(var.env_name)                  # Converts string to lowercase
#   env_trimmed = trim(var.env_name, " ")              # Trims spaces from both sides
#   env_clean   = chomp(local.env_trimmed)             # Removes trailing newline if any

#   absolute_number = abs(var.numbers[0])              # Returns absolute value
#   max_number      = max(var.numbers...)               # Returns maximum number
#   reversed_list   = reverse(var.numbers)              # Reverses list order

#   # -------------------------
#   # String & collection functions
#   # -------------------------

#   ports_list = split(",", var.ports_csv)             # Splits string into list
#   ports_join = join("-", local.ports_list)            # Joins list into string

#   env_replaced = replace(local.env_lower, " ", "")   # Replaces characters in string
#   env_substr   = substr(local.env_replaced, 0, 3)    # Extracts substring

#   merged_tags = merge(                                # Merges multiple maps
#     var.tags_map,
#     {
#       environment = local.env_replaced
#       managed_by  = "terraform"
#     }
#   )

#   port_lookup = lookup(var.tags_map, "owner", "na")  # Looks up value in map with default
#   has_owner   = contains(keys(var.tags_map), "owner")# Checks if key exists
#   ends_with_t = endswith(local.env_replaced, "t")    # Checks string ending

#   # -------------------------
#   # Type & collection helpers
#   # -------------------------

#   ports_set = toset(local.ports_list)                 # Converts list to set
#   ports_all = concat(local.ports_list, ["8080"])      # Concatenates lists

#   # -------------------------
#   # File & path functions
#   # -------------------------

#   current_dir = dirname(path.module)                  # Gets current directory path
#   file_exists = fileexists("${path.module}/variables.tf") # Checks file existence

#   # -------------------------
#   # Time & formatting
#   # -------------------------

#   current_time     = timestamp()                      # Current UTC timestamp
#   formatted_date   = formatdate("DD-MM-YYYY", local.current_time) # Formats date

#   # -------------------------
#   # Sensitive function
#   # -------------------------

#   sensitive_value = sensitive("my-secret-value")      # Marks value as sensitive
# }

# # ------------------------------------------------------------
# # RESOURCE USING FUNCTION OUTPUTS
# # ------------------------------------------------------------

# resource "azurerm_resource_group" "functions_demo" {
#   name     = "rg-func-${local.env_substr}"             # Uses substr + replace output
#   location = var.location

#   tags = local.merged_tags                             # Uses merge function output
# }

# # ------------------------------------------------------------
# # OUTPUTS – FUNCTION RESULTS
# # ------------------------------------------------------------

# output "easy_functions" {
#   description = "Results of easy Terraform functions"
#   value = {
#     lower_env    = local.env_lower
#     trimmed_env  = local.env_trimmed
#     absolute     = local.absolute_number
#     max_value    = local.max_number
#     reversed     = local.reversed_list
#   }
# }

# output "string_and_collections" {
#   description = "String and collection function results"
#   value = {
#     ports_list   = local.ports_list
#     ports_joined = local.ports_join
#     replaced_env = local.env_replaced
#     substring    = local.env_substr
#   }
# }

# output "helpers_and_checks" {
#   description = "Helper function results"
#   value = {
#     lookup_owner = local.port_lookup
#     has_owner    = local.has_owner
#     ends_with_t  = local.ends_with_t
#     ports_set    = local.ports_set
#   }
# }

# output "time_and_file" {
#   description = "Time and file related function outputs"
#   value = {
#     current_time   = local.current_time
#     formatted_date = local.formatted_date
#     file_exists    = local.file_exists
#     current_dir    = local.current_dir
#   }
# }

# output "sensitive_demo" {
#   description = "Sensitive output demo"
#   value       = local.sensitive_value
#   sensitive   = true                                   # Hides value in output
# }
