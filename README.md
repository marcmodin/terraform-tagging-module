# Sample Terraform Tag Generator Module

This Terraform module dynamically generates standardized tags for cloud resources based on user inputs. The module ensures that tag values conform to predefined valid values, enhancing consistency and governance across resources.

## Features

- **Input Validation**: Ensures only valid values for tags such as `environment`, `cost-center`, `department`, and `project-id` are accepted.
- **Standardized Tags**: Provides a consistent tagging structure across all resources.
- **Easy Integration**: Can be easily integrated with any Terraform configuration to apply tags to resources.

<!-- BEGIN_TF_DOCS -->
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
