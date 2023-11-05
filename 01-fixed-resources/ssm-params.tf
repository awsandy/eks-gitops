resource "aws_ssm_parameter" "hzid" {
  name        = "/workshop/hzid"
  description = "The vpc id for cluster 1"
  type        = "String"
  value       = aws_route53_zone.keycloak.id

  tags = {
    workshop = "EKS Workshop"
  }
}