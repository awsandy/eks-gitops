export GITOPS_IAM_SSH_KEY_ID=$(echo "aws_iam_user_ssh_key.gitops.id" | terraform console | tr -d '"')
export EKS_CLUSTER_NAME=$(echo "data.aws_ssm_parameter.cluster1_name.insecure_value" | terraform console | tr -d '"')
flux bootstrap git \
  --url=ssh://${GITOPS_IAM_SSH_KEY_ID}@git-codecommit.${AWS_REGION}.amazonaws.com/v1/repos/${EKS_CLUSTER_NAME}-gitops \
  --branch=main \
  --private-key-file=${HOME}/.ssh/gitops_ssh.pem \
  --silent
