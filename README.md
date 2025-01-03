# Sample Terraform Tag Generator Module

This Terraform module dynamically generates standardized tags for cloud resources based on user inputs. The module ensures that tag values conform to predefined valid values, enhancing consistency and governance across resources. Inspired by Cloudposse's [terraform-null-label](https://github.com/cloudposse/terraform-null-label) module.

Feel free to take this module and make it your own.

## Features

- **Input Validation**: Ensures only valid values for tags such as `environment`, `cost-center`, and `project-id` are accepted.
- **Standardized Tags**: Provides a consistent tagging structure across all resources.
- **Context**: Supports deeply merging values from context. Adding the ability to extend values needed in different parts of your configuration.
- **Easy Integration**: Can be easily integrated with any Terraform configuration to apply tags to resources.

## How to Use

To use this module in your Terraform configuration, grab the following example code block and provide the necessary inputs to test it out.

```hcl
  module "common_tags" {
    source      = "git@github.com:marcmodin/sample-terraform-aws-tags-module.git?ref=v0.1.0"
    environment = "prd"
    cost_center = "sb-456"
    project     = "proj-202"
    region      = "eu-north-1"

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
```

---

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_tags"></a> [additional\_tags](#input\_additional\_tags) | Additional tags to be merged with the generated tags | `map(string)` | `{}` | no |
| <a name="input_context"></a> [context](#input\_context) | Contextual variables for nested modules. Expects a map of tags eg. `module.tags.tags` | `any` | `{}` | no |
| <a name="input_cost_center"></a> [cost\_center](#input\_cost\_center) | The cost center identifier (e.g., sb-123, sb-456, sb-789) | `string` | `""` | no |
| <a name="input_enable_hash_id"></a> [enable\_hash\_id](#input\_enable\_hash\_id) | Whether to generate a unique resource ID. Useful for globally unique names required for S3 buckets | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment of the resource (e.g., dev, tst, stg, qa, prd) | `string` | `""` | no |
| <a name="input_format"></a> [format](#input\_format) | The format of the resource ID (e.g., '$cost\_center-$environment-$region-$project') | `string` | `"$cost_center-$environment-$region-$project"` | no |
| <a name="input_project"></a> [project](#input\_project) | The abbreviated project name associated with the resource | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | Optional AWS region to include in the resource ID, limited to EU and US regions | `string` | `""` | no |
| <a name="input_services"></a> [services](#input\_services) | List of AWS services to include in the resource IDs | `list(string)` | `[]` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_additional_tags"></a> [additional\_tags](#output\_additional\_tags) | The additional tags to be merged with the generated tags |
| <a name="output_context"></a> [context](#output\_context) | The context of the resource. Useful for troubleshooting and debugging |
| <a name="output_resource_id"></a> [resource\_id](#output\_resource\_id) | The generated resource ID based on the specified format |
| <a name="output_resource_ids"></a> [resource\_ids](#output\_resource\_ids) | A map of resource IDs including the base ID and service-specific IDs |
| <a name="output_tags"></a> [tags](#output\_tags) | The combined tags to be applied to resources |
<!-- END_TF_DOCS -->

---

## Contributing

We use [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) for all commits in this repo, the main ones is all you need.

- **fix**: which represents bug fixes, and correlates to a SemVer patch.
- **feat**: which represents a new feature, and correlates to a SemVer minor.
- **feat!**:, or fix!:, refactor!:, etc., which represent a breaking change (indicated by the !) and will result in a SemVer major.

Use Squash Merge on Pull-Requests as per [Linear git commit history](https://github.com/googleapis/release-please/tree/main#linear-git-commit-history-use-squash-merge)

### Releasing Please

Releasing a new version of the module is an automated process. This project uses [Release-Please-Action](https://github.com/googleapis/release-please-action) (based on Google's [official release-please tool](https://github.com/googleapis/release-please/tree/main)) which runs when a Pull-Request is merged to main.

🚀 You dont need to manually bump the module version, nor update changelog, release-please-action handles that for us!

When changes are merged to main release-please will go though the commits and generate a release candidate in the form of a new pull-request.

For more information on how to customize releases further, see [customizing releases](https://github.com/googleapis/release-please/blob/main/docs/customizing.md)

## Terraform Tests

This project uses terraform's built in testing suite [Terraform Test](https://developer.hashicorp.com/terraform/language/tests#tests) to validate that the module produce expected results in scenarios covered.

Initialize the Terraform configuration in the `root` of this module to install modules and any required providers. Any time you add a new provider or module to your configuration or tests, you must run the terraform init command.

```bash
terraform init
```

Run terraform test. Terraform authenticates the AWS provider defined in your tests if it exists using your provider credentials the same way it does for your regular configuration.

```bash
terraform test

tests/default.tftest.hcl... in progress
  run "simple_plan_validate_module_resource_id"... pass
  run "simple_plan_validate_module_tags"... pass
tests/default.tftest.hcl... tearing down
tests/default.tftest.hcl... pass

Success! 2 passed, 0 failed.
```
