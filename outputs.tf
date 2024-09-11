output "tags" {
  description = "The tags map to be applied to resources"
  value       = local.base_tags
}

output "merged_tags" {
  description = "The merged tags map to be applied to resources"
  value       = local.merged_tags
}

output "resource_id" {
  description = "The generated resource ID based on environment and project ID"
  value       = local.id
}

output "resource_id_with_hash" {
  description = "The generated resource ID with hash based on environment and project ID"
  value       = local.hashed_id
}

output "s3_resource_id" {
  description = "The generated resource ID for S3 based on environment and project ID"
  value       = local.s3_safe_id
}

output "additional_tags" {
  description = "The additional tags to be merged with the generated tags"
  value       = var.additional_tags
}