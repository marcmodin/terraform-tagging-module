run "with_context_plan_validate_module_context" {
  command = plan

  module {
    source = "./examples/with_context"
  }

  assert {
    condition     = length(keys(module.tags.tags)) == 6
    error_message = "Expected 5 tags to be present, rendered: ${length(module.tags.tags)}"
  }
}
