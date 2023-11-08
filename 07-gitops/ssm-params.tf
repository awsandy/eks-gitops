resource "aws_ssm_parameter" "gitops-iam-ssh-key-id" {
  name        = "/workshop/gitops-iam-ssh-key-id"
  description = "gitops-iam-ssh-key-id"
  type        = "String"
  value       = aws_iam_user_ssh_key.gitops.id

  tags = {
    workshop = "EKS Workshop"
  }
}

resource "aws_ssm_parameter" "gitops-unique-id" {
  name        = "/workshop/gitops-unique-id"
  description = "gitops-unique-id"
  type        = "String"
  #value       = aws_iam_user.gitops.unique_id
  value       = aws_iam_user.gitops.id

  tags = {
    workshop = "EKS Workshop"
  }
}
