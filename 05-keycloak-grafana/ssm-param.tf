resource "aws_ssm_parameter" "keycloak_cert_arn" {
  name        = "/workshop/keycloak_cert_arn"
  description = "keycloak_cert_arn"
  type        = "String"
  value       = aws_acm_certificate.keycloak.arn

  tags = {
    workshop = "EKS Workshop"
  }
}


data "aws_ssm_parameter" "hzid" {
  name        = "/workshop/hzid"
}

