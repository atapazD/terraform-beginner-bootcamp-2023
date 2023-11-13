 module "terrahouse_aws" {
   source              = "./modules/terrahouse_aws"
   user_uuid           = var.teacherseat_user_uuid

   error_html_filepath = var.error_html_filepath
   index_html_filepath = var.index_html_filepath
   content_version     = var.content_version
   assets_path = var.assets_path
 }

terraform {
  required_providers {
    terratowns = {
      source  = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
}

provider "terratowns" {
  endpoint  = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid
  token     = var.terratowns_access_token
}

resource "terratowns_home" "home" {
  name = "Fallout 3!!!"
  description = <<DESCRIPTION
  Playing fallout 3 is like getting lost in a new world where the choices you make affect the outcome of the story told.
  DESCRIPTION
  domain_name = module.terrahouse_aws.cloudfront_url
#  domain_name= "3fafa3.cloudfront.net"
  town="missingo"
  content_version = 1
}