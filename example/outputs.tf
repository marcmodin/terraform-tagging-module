output "bucket" {
  value       = aws_s3_bucket.example.id
  description = "The ID of the S3 bucket"
}

output "resource_id" {
  value       = module.common_tags.resource_id
  description = "The generated resource ID"
}
