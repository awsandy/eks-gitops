terraform init
terraform apply -auto-approve
git clone https://github.com/aws-observability/terraform-aws-observability-accelerator.git
cd terraform-aws-observability-accelerator/examples/existing-cluster-with-base-and-infra
cp ../../../main.tf.sav main.tf
pwd
terraform init
# (mandatory) AWS Region where your resources will be located
export TF_VAR_aws_region="eu-west-1"

# (mandatory) EKS Cluster name
export TF_VAR_eks_cluster_id=$(aws eks list-clusters | jq -r '.clusters[]')

gid=$(aws grafana list-workspaces --query workspaces[].id --output text)
export TF_VAR_managed_grafana_workspace_id=$gid
export TF_VAR_grafana_api_key=`aws grafana create-workspace-api-key --key-name "observability-accelerator-$(date +%s)" --key-role ADMIN --seconds-to-live 1200 --workspace-id $TF_VAR_managed_grafana_workspace_id --query key --output text`

# (optional) Leave it empty for a new workspace to be created
# managed_prometheus_workspace_id = "prometheus-workspace-id"

#terraform apply -var-file=terraform.tfvars
terraform apply -auto-approve