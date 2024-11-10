output "id" {
  value       = aws_s3_bucket.default.id
  description = "The output of the S3 bucket id"
}

output "tags" {
  value       = aws_s3_bucket.default.tags
  description = "The output of the S3 bucket tags"
}
