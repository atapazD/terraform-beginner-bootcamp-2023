

output "random_bucket_name" {
  value = var.bucket_name
}


#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
resource "aws_s3_bucket" "website_bucket" {
  #Bucket naming Rules
  #https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html

  bucket = var.bucket_name
  tags = {
    UserUUID = var.user_uuid
  }
}
