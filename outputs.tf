####################################################################################################
# Outputs
####################################################################################################

output "tags" {
  description = "The combined tags to be applied to resources"
  value       = local.merged_tags
}

output "resource_id" {
  description = "The generated resource ID based on the specified format"
  value       = local.resource_id
}

output "resource_ids" {
  description = "A map of resource IDs including the base ID and service-specific IDs"
  value       = local.resource_id_map
}

output "additional_tags" {
  description = "The additional tags to be merged with the generated tags"
  value       = var.additional_tags
}

output "context" {
  description = "The context of the resource. Useful for troubleshooting and debugging"
  value       = var.context
}
