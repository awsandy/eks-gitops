resource "aws_ssm_parameter" "cluster1_vpcid" {
  name        = "/workshop/cluster1_vpcid"
  description = "The vpc id for cluster 1"
  type        = "String"
  value       = module.vpc.vpc_id
  tags = {
    workshop = "EKS Workshop"
  }
}

resource "aws_ssm_parameter" "cluster1_vpc_cidr_block" {
  name        = "/workshop/cluster1_vpc_cidr_block"
  description = "The vpc cidr block for cluster 1"
  type        = "String"
  value       = module.vpc.vpc_cidr_block
  tags = {
    workshop = "EKS Workshop"
  }
}

resource "aws_ssm_parameter" "cluster1_vpc_private_subnets" {
  name        = "/workshop/cluster1_private_subnets"
  description = "The private subnet ids for cluster 1"
  type        = "StringList"
  value = jsonencode(module.vpc.private_subnets)
  tags = {
    workshop = "EKS Workshop"
  }
}

resource "aws_ssm_parameter" "cluster1_vpc_intra_subnets" {
  name        = "/workshop/cluster1_intra_subnets"
  description = "The intra subnets for cluster 1"
  type        = "StringList"
  value = jsonencode(module.vpc.intra_subnets)
  tags = {
    workshop = "EKS Workshop"
  }
}