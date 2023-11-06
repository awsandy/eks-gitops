data "aws_ssm_parameter" "keycloak_cert_arn" {
  name        = "/workshop/keycloak_cert_arn"
}


data "aws_ssm_parameter" "hzid" {
  name        = "/workshop/hzid"
}

