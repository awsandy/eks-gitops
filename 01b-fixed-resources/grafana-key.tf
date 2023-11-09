resource "aws_grafana_workspace_api_key" "key" {
  key_name        = "observability-key"
  key_role        = "ADMIN"
  seconds_to_live = 7200
  workspace_id    = aws_grafana_workspace.workshop.id
}

resource "aws_ssm_parameter" "grafana-key" {
  name        = "/workshop/grafana-key"
  description = "The Grafana key"
  type        = "String"
  value       = aws_grafana_workspace_api_key.key.key

  tags = {
    workshop = "EKS Workshop"
  }
}