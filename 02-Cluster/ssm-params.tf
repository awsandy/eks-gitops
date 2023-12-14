data "aws_ssm_parameter" "cluster1_vpcid" {
  name        = "/workshop/cluster1_vpcid"
}

data "aws_ssm_parameter" "cluster1_vpc_cidr_block" {
  name        = "/workshop/cluster1_vpc_cidr_block"
}

data "aws_ssm_parameter" "cluster1_vpc_private_subnets" {
  name        = "/workshop/cluster1_private_subnets"
}

data "aws_ssm_parameter" "cluster1_vpc_intra_subnets" {
  name        = "/workshop/cluster1_intra_subnets"
}

resource "aws_ssm_parameter" "cluster1_name" {
  name        = "/workshop/cluster1_name"
  description = "The cluster 1 name"
  type        = "String"
  value       = module.eks.cluster_name

  tags = {
    workshop = "EKS Workshop"
  }
}

resource "aws_ssm_parameter" "cluster1_endpoint" {
  name        = "/workshop/cluster1_endpoint"
  description = "The cluster 1 endpoint"
  type        = "String"
  value       = module.eks.cluster_endpoint

  tags = {
    workshop = "EKS Workshop"
  }
}
resource "aws_ssm_parameter" "cluster1_version" {
  name        = "/workshop/cluster1_version"
  description = "The cluster 1 endpoint"
  type        = "String"
  value       = module.eks.cluster_version

  tags = {
    workshop = "EKS Workshop"
  }
}

resource "aws_ssm_parameter" "cluster1_oidc_provider_arn" {
  name        = "/workshop/cluster1_oidc_provider_arn"
  description = "The cluster 1 oidc provider arn"
  type        = "String"
  value       = module.eks.oidc_provider_arn

  tags = {
    workshop = "EKS Workshop"
  }
}

resource "aws_ssm_parameter" "cluster1_certificate_authority_data" {
  name        = "/workshop/cluster1_certificate_authority_data"
  description = "The cluster 1 certificate_authority_data"
  type        = "String"
  value       = module.eks.cluster_certificate_authority_data

  tags = {
    workshop = "EKS Workshop"
  }
}


  #module.eks.cluster_certificate_authority_data
  #cluster_name      = module.eks.cluster_name
  #cluster_endpoint  = module.eks.cluster_endpoint
  #cluster_version   = module.eks.cluster_version
  #oidc_provider_arn = module.eks.oidc_provider_arn
