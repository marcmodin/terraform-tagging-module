run "simple_plan_validate_module_resource_id" {
  command = plan

  module {
    source = "./examples/simple"
  }

  # Validate that the length of the S3 resource ID is less than 63 characters
  assert {
    condition     = length(module.tags.resource_ids["s3"]) < 63
    error_message = "S3 resource ID is too long: ${module.tags.resource_ids["s3"]}"
  }
  # Validate that the S3 resource ID is unique and not the same as the default resource ID
  assert {
    condition     = module.tags.resource_ids["s3"] != module.tags.resource_ids["default"]
    error_message = "S3 resource ID is the same as the default resource ID"
  }
}

run "simple_plan_validate_module_tags" {
  command = plan

  module {
    source = "./examples/simple"
  }

  # Validate that the length of the S3 resource ID is less than 63 characters
  assert {
    condition     = length(keys(module.tags.tags)) == 5
    error_message = "Expected 5 tags to be present, rendered: ${length(module.tags.tags)}"
  }
}
