locals {
  # Map of AWS regions and their short forms
  region_short_map = {
    "us-east-1"    = "use1"
    "us-east-2"    = "use2"
    "eu-west-1"    = "euw1"
    "eu-west-2"    = "euw2"
    "eu-west-3"    = "euw3"
    "eu-north-1"   = "eun1"
    "eu-central-1" = "euc1"
  }

  # Fetch the short form of aws_region if provided, else use empty string
  short_region = lookup(local.region_short_map, var.region, "")


  # Generate the full id with optional region short code
  id = "${var.environment}-${var.project_id}${local.short_region != "" ? "-${local.short_region}" : ""}"

  # Generate a random string if random is set to true
  id_hash = var.hash_id ? md5(local.id) : ""


  # Generate the resource_id with optional region short code
  hashed_id = "${local.id}-${local.id_hash}"

  # Genarate the resource id for s3 with optional region short code, and replace any non-alphanumeric characters with "-" while keeping the length to 63 characters

  s3_safe_id = substr(replace(replace(lower("${local.id}-s3-${local.id_hash}"), "[^a-z0-9]", "-"), "-+", "-"), 0, 63)


  # Generate tags
  base_tags = {
    "environment" = var.environment
    "cost-center" = var.cost_center
    "department"  = var.department
    "project-id"  = var.project_id
  }

  # Merge the base tags with additional tags
  merged_tags = merge(local.base_tags, var.additional_tags)
}
