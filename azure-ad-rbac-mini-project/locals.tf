# ------------------------------------------------------------
# Non-sensitive user map for for_each usage
# ------------------------------------------------------------
locals {
  users_for_each = {
    for key, user in var.users :
    key => {
      first_name = user.first_name
      last_name  = user.last_name
    }
  }
}
