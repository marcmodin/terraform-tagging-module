module "tags" {
  source      = "../../"
  environment = var.environment
  cost_center = "sb-456"
  project     = "frnd"
  region      = var.region

  additional_tags = {
    "application" = "annual-reporting-service"
  }
}

provider "aws" {
  region = var.region
  default_tags {
    tags = module.tags.tags
  }
}

module "bucket" {
  source  = "./s3"
  context = module.tags.tags
  tags = {
    "compliancy" = "pci"
  }
}
