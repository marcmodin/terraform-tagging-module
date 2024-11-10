####################################################################################################
# Variables
####################################################################################################

variable "region" {
  description = "Optional AWS region to include in the resource ID, limited to EU and US regions"
  type        = string
  default     = ""

  validation {
    condition     = can(regex("^(us|eu)-[a-z]+-[0-9]+$", var.region)) || var.region == ""
    error_message = "Only AWS regions from 'us' and 'eu' are allowed, or leave the region empty. Example: 'us-east-1', 'eu-west-1'"
  }
}

variable "environment" {
  description = "The environment of the resource (e.g., dev, tst, stg, qa, prd)"
  type        = string
  default     = ""

  validation {
    condition     = var.environment == "" || contains(["dev", "tst", "stg", "qa", "prd"], var.environment)
    error_message = "Environment must be one of 'dev', 'tst', 'stg', 'qa', or 'prd'."
  }
}

variable "cost_center" {
  description = "The cost center identifier (e.g., sb-123, sb-456, sb-789)"
  type        = string
  default     = ""

  validation {
    condition     = var.cost_center == "" || can(regex("^sb-[0-9]+$", var.cost_center))
    error_message = "Cost center must start with 'sb-' followed by numbers, e.g., 'sb-123', 'sb-456', or 'sb-789'."
  }
}

variable "project" {
  description = "The abbreviated project name associated with the resource"
  type        = string
  default     = ""
}

variable "additional_tags" {
  description = "Additional tags to be merged with the generated tags"
  type        = map(string)
  default     = {}
}

variable "format" {
  description = "The format of the resource ID (e.g., '$cost_center-$environment-$region-$project')"
  type        = string
  default     = "$cost_center-$environment-$region-$project"
}

variable "services" {
  description = "List of AWS services to include in the resource IDs"
  type        = list(string)
  default     = []
}

variable "enable_hash_id" {
  description = "Whether to generate a unique resource ID. Useful for globally unique names required for S3 buckets"
  type        = bool
  default     = false
}

variable "context" {
  # need any here otherwise additional_tags will not be merged into the context
  type        = any
  description = "Contextual variables for nested modules. Expects a map of tags eg. `module.tags.tags`"
  default     = {}
}
