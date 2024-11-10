module "tags" {
  source      = "../../"
  environment = "prd"
  cost_center = "sb-456"
  project     = "frnd"
  region      = "eu-north-1"

  enable_hash_id = true
  services       = ["s3"]

  additional_tags = {
    "application" = "annual-reporting-service"
  }
}
