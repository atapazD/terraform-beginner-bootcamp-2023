# module "terrahouse_aws" {
#   source              = "./modules/terrahouse_aws"
#   user_uuid           = var.user_uuid
#   bucket_name         = var.bucket_name
#   error_html_filepath = var.error_html_filepath
#   index_html_filepath = var.index_html_filepath
#   content_version     = var.content_version
#   assets_path = var.assets_path
# }

terraform {
  required_providers {
    terratowns = {
      source  = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
}

provider "terratowns" {
  endpoint  = "http://localhost:4567/api"
  user_uuid = "e328f4ab-b99f-421c-84c9-4ccea042c7d1"
  token     = "9b49b3fb-b8e9-483c-b703-97ba88eef8e0"
}

resource "terratowns_home" "home" {
  name = "Fallout 3!!!"
  description = <<DESCRIPTION
  Playing fallout 3 is like getting lost in a new world where the choices you make affect the outcome of the story told.
  DESCRIPTION
  domain_name = "3fdq3gz.cloudfront.net"
  town="gamers-grotto"
  content_version = 1
}