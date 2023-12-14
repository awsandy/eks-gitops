locals {
  #name            = "ex-${replace(basename(path.cwd), "_", "-")}"
  name            = var.CLUSTER1_NAME
  cluster_version = "1.27"
  region          = var.region


  vpc_cidr = "10.0.0.0/16"
  azs      = slice(data.aws_availability_zones.available.names, 0, 3)

  tags = {
    Example    = local.name
    GithubRepo = "terraform-aws-eks"
    GithubOrg  = "terraform-aws-modules"
  }
}