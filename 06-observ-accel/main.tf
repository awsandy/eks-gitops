provider "kubernetes" {
  host                   = data.aws_ssm_parameter.cluster1_endpoint.value
  cluster_ca_certificate = base64decode(data.aws_ssm_parameter.cluster1_certificate_authority_data.value)
  config_path = "~/.kube/config"
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    # This requires the awscli to be installed locally where Terraform is executed
    args = ["eks", "get-token", "--cluster-name", data.aws_ssm_parameter.cluster1_name.value]
  }
}

provider "helm" {
  kubernetes {
    host                   = data.aws_ssm_parameter.cluster1_endpoint.value
    cluster_ca_certificate = base64decode(data.aws_ssm_parameter.cluster1_certificate_authority_data.value)

    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "aws"
      # This requires the awscli to be installed locally where Terraform is executed
      args = ["eks", "get-token", "--cluster-name", data.aws_ssm_parameter.cluster1_name.value]
    }
  }
}

provider "kubectl" {
  apply_retry_count      = 5
  host                   = data.aws_ssm_parameter.cluster1_endpoint.value
  cluster_ca_certificate = base64decode(data.aws_ssm_parameter.cluster1_certificate_authority_data.value)
  load_config_file       = false

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    # This requires the awscli to be installed locally where Terraform is executed
    args = ["eks", "get-token", "--cluster-name", data.aws_ssm_parameter.cluster1_name.value]
  }
}





module "aws_observability_accelerator" {
  # use release tags and check for the latest versions
  # https://github.com/aws-observability/terraform-aws-observability-accelerator/releases
  source = "github.com/aws-observability/terraform-aws-observability-accelerator?ref=v2.10.0"

  aws_region     = data.aws_region.current.name
  #eks_cluster_id = data.aws_ssm_parameter.cluster1_name.value

  # As Grafana shares a different lifecycle, we recommend using an existing workspace.
  managed_grafana_workspace_id = data.aws_ssm_parameter.grafana-id.value
}



module "eks_monitoring" {
  source = "github.com/aws-observability/terraform-aws-observability-accelerator//modules/eks-monitoring?ref=v2.1.0"

  eks_cluster_id = data.aws_ssm_parameter.cluster1_name.value

  dashboards_folder_id            = module.eks_observability_accelerator.grafana_dashboards_folder_id
  managed_prometheus_workspace_id = module.eks_observability_accelerator.managed_prometheus_workspace_id

  managed_prometheus_workspace_endpoint = module.eks_observability_accelerator.managed_prometheus_workspace_endpoint
  managed_prometheus_workspace_region   = module.eks_observability_accelerator.managed_prometheus_workspace_region

  #enable_logs = true
  enable_tracing = true
}


# Deploy the ADOT Container Insights

module "eks_container_insights" {
  source = "github.com/aws-observability/terraform-aws-observability-accelerator//modules/eks-container-insights"

  #source = "github.com/aws-observability/terraform-aws-observability-accelerator//modules/eks-container-insights?ref=v2.5.4"
  eks_cluster_id = data.aws_ssm_parameter.cluster1_name.value
}
