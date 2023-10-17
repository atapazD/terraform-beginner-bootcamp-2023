variable "user_uuid" {
 description = "User UUID in a specific format"
  validation {
    condition     = can(regex("^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$", var.user_uuid))
    error_message = "Invalid user UUID format. The UUID should be in the format: 8-4-4-4-12 hexadecimal characters separated by hyphens."
  }
}

