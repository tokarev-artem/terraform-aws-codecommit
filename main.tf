resource "aws_codecommit_repository" "this" {
  repository_name = var.repository_name
  description     = var.description
  default_branch  = var.default_branch
  kms_key_id      = var.kms_key_id
  tags            = var.tags
}

resource "aws_codecommit_approval_rule_template" "this" {
  count       = length(var.rule_approval_pool_members) > 0 ? 1 : 0
  name        = "${var.repository_name}-approval-rule"
  description = var.rule_template_description
  content = jsonencode({
    Version               = "2018-11-08"
    DestinationReferences = var.rule_destination_refs
    Statements = [
      {
        Type                    = "Approvers"
        NumberOfApprovalsNeeded = var.rule_number_of_approvals_needed
        ApprovalPoolMembers     = var.rule_approval_pool_members
      }
    ]
  })
}

resource "aws_codecommit_approval_rule_template_association" "this" {
  count                       = length(var.rule_approval_pool_members) > 0 ? 1 : 0
  approval_rule_template_name = aws_codecommit_approval_rule_template.this[0].name
  repository_name             = aws_codecommit_repository.this.repository_name
}

resource "aws_codecommit_trigger" "this" {
  count           = var.trigger_destination_arn != null ? 1 : 0
  repository_name = aws_codecommit_repository.this.id

  trigger {
    name            = "${var.repository_name}-trigger"
    destination_arn = var.trigger_destination_arn
    custom_data     = var.trigger_custom_data
    events          = var.trigger_events
    branches        = var.trigger_branches
  }
}
