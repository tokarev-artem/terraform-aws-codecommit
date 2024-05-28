# Codecommit AWS module

# Simple repo:

```hcl
  module "simple" {
    source  = "tokarev-artem/codecommit/aws"

    repository_name = "react"
    description     = "Frontend app"

    tags = {
      Role = "frontend"
    }
  }
```

# Multiple repositories:
```hcl
  module "multiple" {
    for_each = {
      frontend-react = {
        description = "react app"
      }
      backend-typescript = {
        description = "backend app"
      }
    }
    source          = "tokarev-artem/codecommit/aws"
    repository_name = each.key
    description     = each.value.description
    kms_key_id      = "arn:aws:kms:eu-central-1:1234567891011:key/cb121336-dddd-4a0d-abcd-914f5d2c2e2a"

    rule_template_description       = "Approval rule template for pull requests"
    rule_number_of_approvals_needed = 2
    rule_approval_pool_members      = ["arn:aws:iam::1234567891011:user/JohnSnow"]
    rule_destination_refs           = ["refs/heads/main", "refs/heads/dev"]

    trigger_destination_arn = "arn:aws:sns:eu-central-1:1234567891011:test-topic"
    trigger_custom_data     = "Custom data for the trigger"
    trigger_events          = ["updateReference", "createReference"]
    trigger_branches        = ["dev", "main"]

    tags = {
      ownder = "horns-and-hoofs"
    }
  }
```



## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_repository_name"></a> [repository\_name](#input\_repository\_name) | The name of the CodeCommit repository | `string` | n/a | yes |
| <a name="input_approval_rule_branch_name"></a> [approval\_rule\_branch\_name](#input\_approval\_rule\_branch\_name) | A branch name to apply approval rule to | `string` | `"main"` | no |
| <a name="input_default_branch"></a> [default\_branch](#input\_default\_branch) | The default branch of the repository. The branch specified here needs to exist. | `string` | `"main"` | no |
| <a name="input_description"></a> [description](#input\_description) | The description of the CodeCommit repository | `string` | `""` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | The ARN of the encryption key. If no key is specified, the default aws/codecommit Amazon Web Services managed key is used. | `string` | `null` | no |
| <a name="input_rule_approval_pool_members"></a> [rule\_approval\_pool\_members](#input\_rule\_approval\_pool\_members) | The list of ARNs for users or groups who can approve pull requests | `list(string)` | `[]` | no |
| <a name="input_rule_destination_refs"></a> [rule\_destination\_refs](#input\_rule\_destination\_refs) | List of destination references for the approval rule template | `list(string)` | <pre>[<br>  "refs/heads/main"<br>]</pre> | no |
| <a name="input_rule_number_of_approvals_needed"></a> [rule\_number\_of\_approvals\_needed](#input\_rule\_number\_of\_approvals\_needed) | The number of approvals needed for a pull request | `number` | `"1"` | no |
| <a name="input_rule_template_description"></a> [rule\_template\_description](#input\_rule\_template\_description) | The description of the approval rule template | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the resource | `map(string)` | `{}` | no |
| <a name="input_trigger_branches"></a> [trigger\_branches](#input\_trigger\_branches) | The branches that will be included in the trigger configuration. If no branches are specified, the trigger will apply to all branches. | `list(any)` | `[]` | no |
| <a name="input_trigger_custom_data"></a> [trigger\_custom\_data](#input\_trigger\_custom\_data) | Any custom data associated with the trigger | `string` | `""` | no |
| <a name="input_trigger_destination_arn"></a> [trigger\_destination\_arn](#input\_trigger\_destination\_arn) | The ARN of the resource that is the target of the trigger | `string` | `null` | no |
| <a name="input_trigger_events"></a> [trigger\_events](#input\_trigger\_events) | The events that will trigger the action (e.g., all, updateReference, createReference, deleteReference) | `list(string)` | <pre>[<br>  "all"<br>]</pre> | no |
| <a name="input_trigger_name"></a> [trigger\_name](#input\_trigger\_name) | The name of the trigger | `string` | `null` | no | 

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_approval_rule_template_id"></a> [approval\_rule\_template\_id](#output\_approval\_rule\_template\_id) | ID of the approval rule template |
| <a name="output_approval_rule_template_name"></a> [approval\_rule\_template\_name](#output\_approval\_rule\_template\_name) | Name of the approval rule template |
| <a name="output_repository_arn"></a> [repository\_arn](#output\_repository\_arn) | ARN of the CodeCommit repository |
| <a name="output_repository_clone_url_http"></a> [repository\_clone\_url\_http](#output\_repository\_clone\_url\_http) | HTTP clone URL of the CodeCommit repository |
| <a name="output_repository_clone_url_ssh"></a> [repository\_clone\_url\_ssh](#output\_repository\_clone\_url\_ssh) | SSH clone URL of the CodeCommit repository |
| <a name="output_repository_name"></a> [repository\_name](#output\_repository\_name) | Name of the CodeCommit repository |
| <a name="output_trigger_id"></a> [trigger\_id](#output\_trigger\_id) | ID of the CodeCommit trigger |