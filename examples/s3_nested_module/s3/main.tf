
module "context" {
  source          = "../../../"
  enable_hash_id  = true
  additional_tags = var.tags
  services        = ["s3"]
  context         = var.context
}

resource "aws_s3_bucket" "default" {
  bucket = module.context.resource_ids.s3

  tags = merge(module.context.tags, var.tags)
}
