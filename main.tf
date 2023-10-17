
resource "random_string" "bucket_name" {
  #https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string

  length  = 32
  special = false
  lower   = true
  upper   = false

}

output "random_bucket_name" {
  value = random_string.bucket_name.result
}


#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
resource "aws_s3_bucket" "example" {
  #Bucket naming Rules
  #https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html

  bucket = random_string.bucket_name.result
  tags = {
    UserUUID = var.user_uuid
  }
}
