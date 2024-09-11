variable "region" {
  description = "Optional AWS region to include in the resource ID, limited to EU and US regions"
  type        = string
  default     = ""
  validation {
    condition     = can(regex("(^(us|eu)-[a-z]+-[0-9]+$)|^$", var.region))
    error_message = "Only AWS regions from 'us' and 'eu' are allowed, or leave the region empty. Example: 'us-east-1', 'eu-west-1'"
  }
}

variable "environment" {
  description = "The environment of the resource (e.g. development, staging, production)"
  type        = string
  validation {
    condition     = contains(["development", "staging", "production"], var.environment)
    error_message = "Environment must be one of 'development', 'staging', or 'production'."
  }
}

variable "cost_center" {
  description = "The cost center identifier (e.g., b-123, b-456)"
  type        = string
  validation {
    condition     = contains(["b-123", "b-456", "b-789"], var.cost_center)
    error_message = "Cost center must be one of 'b-123', 'b-456', or 'b-789'."
  }
}

variable "department" {
  description = "The department name (e.g., IT, HR, Finance)"
  type        = string
  validation {
    condition     = contains(["IT", "HR", "Finance"], var.department)
    error_message = "Department must be one of 'IT', 'HR', or 'Finance'."
  }
}

variable "project_id" {
  description = "The project ID associated with the resource"
  type        = string
  validation {
    condition     = contains(["proj-101", "proj-202", "proj-303"], var.project_id)
    error_message = "Project ID must be one of 'proj-101', 'proj-202', or 'proj-303'."
  }
}

variable "additional_tags" {
  description = "Additional tags to be merged with the generated tags"
  type        = map(string)
  default     = {}
}

variable "hash_id" {
  description = "Whether to include a random hash in the resource ID"
  type        = bool
  default     = false
}
