module "common_tags" {
  source = "github.com/marcmodin/sample-terraform-aws-tags-module.git?depth=1&ref=v0.1.0"

  environment = "production"
  cost_center = "b-456"
  department  = "Finance"
  project_id  = "proj-202"
  region      = "eu-north-1"
  hash_id     = true

  additional_tags = {
    "application" = "annual-reporting-service"
  }
}

provider "aws" {
  region = "eu-north-1"
  default_tags {
    tags = module.common_tags.tags
  }
}

resource "aws_s3_bucket" "example" {
  bucket = module.common_tags.s3_resource_id

  tags = merge(module.common_tags.tags, module.common_tags.additional_tags)
}
