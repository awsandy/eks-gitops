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



