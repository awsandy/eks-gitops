#module "eks" {
#  source = "terraform-aws-modules/eks/aws"

#  cluster_name    = "my-cluster"
#  cluster_version = "1.27"

#  ... truncated for brevity
#}




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



module "eks_blueprints_addons" {
  
  source = "aws-ia/eks-blueprints-addons/aws"
  version = "~> 1.9" #ensure to update this to the latest/desired version

  cluster_name      = data.aws_ssm_parameter.cluster1_name.value
  cluster_endpoint  = data.aws_ssm_parameter.cluster1_endpoint.value
  cluster_version   = data.aws_ssm_parameter.cluster1_version.value
  oidc_provider_arn = data.aws_ssm_parameter.cluster1_oidc_provider_arn.value


  eks_addons = {
    aws-ebs-csi-driver = {
      most_recent = true
      #service_account_role_arn = module.ebs_csi_driver_irsa.iam_role_arn
    }
  }

  enable_aws_load_balancer_controller     = true
  enable_aws_for_fluentbit                = true # get logs out to CW
  enable_fargate_fluentbit                = true # get logs for fargate pods
  #enable_cluster_proportional_autoscaler = true
  #enable_karpenter                       = true
  #enable_kube_prometheus_stack           = true
  enable_metrics_server                   = true
  enable_aws_cloudwatch_metrics           = true # container insights

  enable_cert_manager                     = true

  #cert_manager_route53_hosted_zone_arns  = ["arn:aws:route53:::hostedzone/XXXXXXXXXXXXX"]

  enable_external_dns                    = true
  external_dns = {
    name          = "external-dns"
    namespace     = "external-dns"
    create_namespace = true
  }
  external_dns_route53_zone_arns = [data.aws_route53_zone.keycloak.arn]


  enable_aws_privateca_issuer             = false
  aws_privateca_issuer = {
    #acmca_arn        = aws_acmpca_certificate_authority.this.arn
    namespace        = "aws-privateca-issuer"
    create_namespace = true
  }

  cert_manager = {
    namespace="cert-manager"
    create_namespace = true
  }

  fargate_fluentbit = {
    flb_log_cw = true
    #namespace=kubernetes_namespace_v1.fluentbit-fargate.id # default is aws_observability
  }

  fargate_fluentbit_cw_log_group = {  #/eks-cluster1/fargate20231031163741692800000002
    create          = true
    use_name_prefix = true # Set this to true to enable name prefi
    name_prefix       = "eks-cluster1-fargate-"
    name = "/eks-cluster1/fargate"
    retention_in_days = 7
    #kms_key_id        = "arn:aws:kms:us-west-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab"
    skip_destroy      = false
  }


  aws_for_fluentbit = {
    namespace=kubernetes_namespace_v1.fluentbit-nodes.id
    enable_containerinsights = true
    set = [{
        name  = "cloudWatchLogs.autoCreateGroup"
        value = true
      }
    ]
  }

  aws_for_fluentbit_cw_log_group = {  # creates log group "/aws/eks/c1-lattice/aws-fluentbit-logs"
    create          = true
    use_name_prefix = true # Set this to true to enable name prefix
    name_prefix     = "eks-cluster1-"
    retention       = 7
    skip_destroy      = false
  }


  aws_cloudwatch_metrics = {
    namespace=kubernetes_namespace_v1.cw-metrics.id
  }

  metrics_server = {
    namespace=kubernetes_namespace_v1.metrics.id
  }

  aws_load_balancer_controller = {
    namespace=kubernetes_namespace_v1.aws_load_balancer_controller.id
    set = [
      {
        name  = "vpcId"
        value = data.aws_ssm_parameter.cluster1_vpcid.value
      },
    ]
  }

  tags = {
    Environment = "dev"
  }
}