resource "aws_ssm_parameter" "hzid" {
  name        = "/workshop/hzid"
  description = "The hosted zone id"
  type        = "String"
  value       = aws_route53_zone.keycloak.id

  tags = {
    workshop = "EKS Workshop"
  }
}

resource "aws_ssm_parameter" "dns-name" {
  name        = "/workshop/dns-name"
  description = "dns name"
  type        = "String"
  value       = aws_route53_zone.keycloak.name

  tags = {
    workshop = "EKS Workshop"
  }
}