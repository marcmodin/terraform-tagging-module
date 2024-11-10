# Set the environment variable to "tst" so that any real resources are not accidentally modified or destroyed.
variables {
  environment = "tst"
}

run "s3_nested_module_plan_validate_context_tags" {
  command = plan

  module {
    source = "./examples/s3_nested_module"
  }

  # Validate that the context module has provided the correct tags
  assert {
    condition     = module.bucket.tags["application"] == "annual-reporting-service"
    error_message = "Bucket tags is missing context provided tag: ${module.tags.additional_tags["application"]}"
  }
}

run "s3_nested_module_apply_validate_resource_id" {
  command = apply

  module {
    source = "./examples/s3_nested_module"
  }

  # Validate that the length of the S3 resource ID is less than 63 characters
  assert {
    condition     = length(module.bucket.id) < 63
    error_message = "S3 resource ID is too long: ${module.bucket.id}"
  }
}