variable "repository_name" {
  type        = string
  description = "The name of the CodeCommit repository"
}

variable "description" {
  type        = string
  default     = ""
  description = "The description of the CodeCommit repository"
}

variable "rule_template_description" {
  type        = string
  default     = ""
  description = "The description of the approval rule template"
}

variable "rule_number_of_approvals_needed" {
  type        = number
  default     = "1"
  description = "The number of approvals needed for a pull request"
}

variable "rule_approval_pool_members" {
  type        = list(string)
  default     = []
  description = "The list of ARNs for users or groups who can approve pull requests"
}

variable "rule_destination_refs" {
  type        = list(string)
  default     = ["refs/heads/main"]
  description = "List of destination references for the approval rule template"
}

variable "approval_rule_branch_name" {
  type        = string
  default     = "main"
  description = "A branch name to apply approval rule to"
}

variable "trigger_name" {
  type        = string
  default     = null
  description = "The name of the trigger"
}

variable "trigger_destination_arn" {
  type        = string
  default     = null
  description = "The ARN of the resource that is the target of the trigger"
}

variable "trigger_custom_data" {
  type        = string
  default     = ""
  description = "Any custom data associated with the trigger"
}

variable "trigger_events" {
  type        = list(string)
  default     = ["all"]
  description = "The events that will trigger the action (e.g., all, updateReference, createReference, deleteReference)"
}
variable "trigger_branches" {
  type        = list(any)
  default     = []
  description = "The branches that will be included in the trigger configuration. If no branches are specified, the trigger will apply to all branches."
}
variable "tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to assign to the resource"
}

variable "kms_key_id" {
  type        = string
  default     = null
  description = "The ARN of the encryption key. If no key is specified, the default aws/codecommit Amazon Web Services managed key is used."
}

variable "default_branch" {
  type        = string
  default     = "main"
  description = "The default branch of the repository. The branch specified here needs to exist."
}
