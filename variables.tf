variable "user_uuid" {
 description = "User UUID in a specific format"
  validation {
    condition     = can(regex("^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$", var.user_uuid))
    error_message = "Invalid user UUID format. The UUID should be in the format: 8-4-4-4-12 hexadecimal characters separated by hyphens."
  }
}

variable "bucket_name" {
  type        = string
  description = "AWS S3 bucket name"

  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9-]{1,61}[a-z0-9]$", var.bucket_name))
    error_message = "Invalid bucket name. It should be between 3 and 63 characters, start and end with a lowercase letter or number, and only contain lowercase letters, numbers, and hyphens."
  }
}
