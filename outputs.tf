output "repository_name" {
  description = "Name of the CodeCommit repository"
  value       = aws_codecommit_repository.this.repository_name
}

output "repository_arn" {
  description = "ARN of the CodeCommit repository"
  value       = aws_codecommit_repository.this.arn
}

output "repository_clone_url_http" {
  description = "HTTP clone URL of the CodeCommit repository"
  value       = aws_codecommit_repository.this.clone_url_http
}

output "repository_clone_url_ssh" {
  description = "SSH clone URL of the CodeCommit repository"
  value       = aws_codecommit_repository.this.clone_url_ssh
}

output "approval_rule_template_name" {
  description = "Name of the approval rule template"
  value       = try(aws_codecommit_approval_rule_template.this[0].name, null)
}

output "approval_rule_template_id" {
  description = "ID of the approval rule template"
  value       = try(aws_codecommit_approval_rule_template.this[0].id, null)
}

output "trigger_id" {
  description = "ID of the CodeCommit trigger"
  value       = try(aws_codecommit_trigger.this[0].id, null)
}