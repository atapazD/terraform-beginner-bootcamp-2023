terraform {
#  cloud {
#    organization = "CloudResumeDZ"
#    workspaces {
#      name = "terra-house-1"
#    }
# }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.21.0"
    }
  }
}
