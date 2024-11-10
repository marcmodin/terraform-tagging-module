variable "region" {
  description = "The region of the resource (e.g., eu-north-1)"
  type        = string
  default     = "eu-north-1"
}

variable "environment" {
  description = "The environment of the resource (e.g., dev, tst, stg, qa, prd)"
  type        = string
  default     = "dev"

  validation {
    condition     = var.environment == "" || contains(["dev", "tst", "stg", "qa", "prd"], var.environment)
    error_message = "Environment must be one of 'dev', 'tst', 'stg', 'qa', or 'prd'."
  }
}