git clone https://github.com/aws-observability/terraform-aws-observability-accelerator.git
cd examples/existing-cluster-with-base-and-infra

terraform init
# (mandatory) AWS Region where your resources will be located
aws_region = "eu-west-1"

# (mandatory) EKS Cluster name
eks_cluster_id = "my-eks-cluster"

####  create grafana

export TF_VAR_managed_grafana_workspace_id=grafana-workspace-id
export TF_VAR_grafana_api_key=`aws grafana create-workspace-api-key --key-name "observability-accelerator-$(date +%s)" --key-role ADMIN --seconds-to-live 1200 --workspace-id $TF_VAR_managed_grafana_workspace_id --query key --output text`

# (optional) Leave it empty for a new workspace to be created
# managed_prometheus_workspace_id = "prometheus-workspace-id"

terraform apply -var-file=terraform.tfvars