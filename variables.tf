variable "terratowns_access_token" {
  type = string
}
variable "teacherseat_user_uuid" {
  type = string
}

variable "terratowns_endpoint" {
  type = string
}

variable "fallout3" {
  type = object({
    public_path     = string
    content_version = number
  })
}

variable "chocolateChip" {
  type = object({
    public_path     = string
    content_version = number
  })
}