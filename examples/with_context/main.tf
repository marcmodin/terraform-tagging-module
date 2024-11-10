# this module provide context for the tags module
module "context" {
  source      = "../../"
  environment = "prd"
  cost_center = "sb-456"
  project     = "frnd"
  region      = "eu-north-1"

  additional_tags = {
    "application" = "annual-reporting-service"
  }
}

# this is the actual module we care about
module "tags" {
  source         = "../../"
  enable_hash_id = true
  services       = ["s3"]
  context        = module.context.tags
  additional_tags = {
    "compliance" = "pci"
  }
}
