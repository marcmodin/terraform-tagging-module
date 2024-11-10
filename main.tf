####################################################################################################
# Modules
####################################################################################################

module "short_region" {
  source = "./short-region"
  region = var.region
}

####################################################################################################
# Locals
####################################################################################################

locals {
  # Base tags: prioritize module inputs over context
  base_tags = {
    cost_center = var.cost_center != "" ? var.cost_center : var.context.cost_center
    environment = var.environment != "" ? var.environment : var.context.environment
    project     = var.project != "" ? var.project : var.context.project
    region      = module.short_region.short_region != "" ? module.short_region.short_region : var.context.region
  }

  # Merge the base tags with additional tags, prioritizing additional tags over context
  merged_tags = merge(local.base_tags, var.additional_tags, var.context)

  # Extract variables from the format string
  formatted_values = [for part in split("-", var.format) : replace(part, "$", "")]

  # Map the formatted values to their corresponding base tag values
  mapped_values = [for key in local.formatted_values : lookup(local.base_tags, key, "")]

  # Generate the base resource ID
  base_resource_id = join("-", compact(local.mapped_values))

  # Optionally append a hash for uniqueness
  resource_id = var.enable_hash_id ? "${local.base_resource_id}-s3-${substr(md5(local.base_resource_id), 0, 6)}" : local.base_resource_id

  # Generates an S3-safe resource ID by lowercasing, replacing invalid characters with hyphens, and truncating to 63 characters
  s3_safe_id = substr(replace(replace(lower(local.resource_id), "[^a-z0-9]", "-"), "-+", "-"), 0, 63)

  # Generate a map of resource IDs including base 'id' and service-specific IDs, applying s3_safe_id only to 's3'
  resource_id_map = merge(
    {
      default = local.base_resource_id
    },
    {
      for svc in var.services :
      svc => (
        # if service is 's3', use the s3_safe_id, otherwise use the base_resource_id
        svc == "s3"
        ? local.s3_safe_id
        : "${local.base_resource_id}-${replace(svc, "_", "-")}"
      )
    }
  )
}
