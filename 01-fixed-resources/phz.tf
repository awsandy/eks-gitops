resource "aws_route53_zone" "primary" {
  name = format("%s.%s",data.aws_caller_identity.current.account_id,var.dn)
}