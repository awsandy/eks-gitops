 data "aws_route53_zone" "keycloak" {
  name = format("%s.%s",data.aws_caller_identity.current.account_id,var.dn)
  private_zone = false
}