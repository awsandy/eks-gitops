data "aws_ssm_parameter" "cluster1_name" {
  name        = "/workshop/cluster1_name"
}

data "aws_ssm_parameter" "grafana-id" {
  name        = "/workshop/grafana-id"
  
}

data "aws_ssm_parameter" "grafana_api_key" {
    name        = "/workshop/grafana_api_key"

}

data "aws_ssm_parameter" "cluster1_endpoint" {
  name        = "/workshop/cluster1_endpoint"
  
}


data "aws_ssm_parameter" "cluster1_oidc_provider_arn" {
  name        = "/workshop/cluster1_oidc_provider_arn" 
}


data "aws_ssm_parameter" "cluster1_certificate_authority_data" {
  name        = "/workshop/cluster1_certificate_authority_data"
}