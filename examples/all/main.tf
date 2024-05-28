module "simple" {
  source          = "../../"
  repository_name = "react"
  description     = "Frontend app"

  tags = {
    Role = "frontend"
  }
}

module "simple-kms" {
  source          = "../../"
  repository_name = "laravel"
  description     = "backend app"
  kms_key_id      = "arn:aws:kms:eu-central-1:1234567891011:key/cb121336-dddd-4a0d-abcd-914f5d2c2e2a"

  tags = {
    Role = "backend"
  }
}

module "simple-kms-rule" {
  source          = "../../"
  repository_name = "auth"
  description     = "backend app"
  kms_key_id      = "arn:aws:kms:eu-central-1:1234567891011:key/cb121336-dddd-4a0d-abcd-914f5d2c2e2a"

  rule_template_description       = "Approval rule template for pull requests"
  rule_number_of_approvals_needed = 1
  rule_approval_pool_members      = ["arn:aws:iam::1234567891011:user/JohnSnow"]
  rule_destination_refs           = ["refs/heads/main", "refs/heads/dev"]

  tags = {
    Role = "backend"
  }
}

module "full" {
  source          = "../../"
  repository_name = "api"
  description     = "backend app"
  kms_key_id      = "arn:aws:kms:eu-central-1:1234567891011:key/cb121336-dddd-4a0d-abcd-914f5d2c2e2a"

  rule_template_description       = "Approval rule template for pull requests"
  rule_number_of_approvals_needed = 1
  rule_approval_pool_members      = ["arn:aws:iam::1234567891011:user/ArtemTokarev"]
  rule_destination_refs           = ["refs/heads/main", "refs/heads/dev"]

  trigger_destination_arn = "arn:aws:sns:eu-central-1:1234567891011:codecommit-topic"
  trigger_custom_data     = "Custom data for the trigger"
  trigger_events          = ["updateReference", "createReference"]
  trigger_branches        = ["dev", "main"]

  tags = {
    Role = "backend"
  }
}

module "multiple" {
  for_each = {
    frontend-react = {
      description = "react app"
    }
    backend-typescript = {
      description = "react app"
    }
  }
  source          = "../../"
  repository_name = each.key
  description     = each.value.description
  kms_key_id      = "arn:aws:kms:eu-central-1:1234567891011:key/cb121336-dddd-4a0d-abcd-914f5d2c2e2a"

  rule_template_description       = "Approval rule template for pull requests"
  rule_number_of_approvals_needed = 2
  rule_approval_pool_members      = ["arn:aws:iam::1234567891011:user/ArtemTokarev"]
  rule_destination_refs           = ["refs/heads/main", "refs/heads/dev"]

  trigger_destination_arn = "arn:aws:sns:eu-central-1:1234567891011:test-topic"
  trigger_custom_data     = "Custom data for the trigger"
  trigger_events          = ["updateReference", "createReference"]
  trigger_branches        = ["dev", "main"]

  tags = {
    ownder = "horns-and-hoofs"
  }
}
