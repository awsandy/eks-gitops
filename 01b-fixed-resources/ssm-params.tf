data "aws_ssm_parameter" "hzid" {
  name        = "/workshop/hzid"
}

data "aws_ssm_parameter" "dns-name" {
  name        = "/workshop/dns-name"

}



resource "aws_ssm_parameter" "grafana-id" {
  name        = "/workshop/grafana-id"
  description = "The Grafana id"
  type        = "String"
  value       = aws_grafana_workspace.workshop.id

  tags = {
    workshop = "EKS Workshop"
  }
}

resource "aws_ssm_parameter" "keycloak_cert_arn" {
  name        = "/workshop/keycloak_cert_arn"
  description = "keycloak_cert_arn"
  type        = "String"
  value       = aws_acm_certificate.keycloak.arn

  tags = {
    workshop = "EKS Workshop"
  }
}