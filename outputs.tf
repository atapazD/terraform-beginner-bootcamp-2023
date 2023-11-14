output "bucket_name" {
  description = "Bucket name for our static website hosting"
  value       = module.home_fallout3_hosting.bucket_name
}

output "s3_website_endpoint" {
  value = module.home_fallout3_hosting.website_endpoint
}

output "cloudfront_url" {
  description = "The Cloudfront distribution domain name"
  value       = module.home_fallout3_hosting.domain_name
}