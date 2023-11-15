terraform {
  required_providers {
    terratowns = {
      source  = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
  cloud {
    organization = "CloudResumeDZ"
    workspaces {
      name = "terra-house-1"
    }
  }
}

provider "terratowns" {
  endpoint  = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid
  token     = var.terratowns_access_token
}
module "home_fallout3_hosting" {
  source          = "./modules/terrahome_aws"
  user_uuid       = var.teacherseat_user_uuid
  public_path     = var.fallout3.public_path
  content_version = var.fallout3.content_version
}

resource "terratowns_home" "home" {
  name        = "Fallout 3!!!"
  description = <<DESCRIPTION
  Playing fallout 3 is like getting lost in a new world where the choices you make affect the outcome of the story told.
  DESCRIPTION
  domain_name = module.home_fallout3_hosting.domain_name
  #  domain_name= "3fafa3.cloudfront.net"
  town            = "gamers-grotto"
  content_version = var.fallout3.content_version
}

 module "home_chocolateChip_hosting" {
   source              = "./modules/terrahome_aws"
   user_uuid           = var.teacherseat_user_uuid
   public_path = var.chocolateChip.public_path
   content_version     = var.chocolateChip.content_version
 }
resource "terratowns_home" "home_chocolateChip" {
  name = "The best Chocolate chip cookie"
  description = <<DESCRIPTION
  The best chocolate chip cookie is the one you can make from scratch
  DESCRIPTION
  domain_name = module.home_chocolateChip_hosting.domain_name
#  domain_name= "3fafa3.cloudfront.net"
  town="missingo"
  content_version = var.chocolateChip.content_version
}