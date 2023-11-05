#arn:aws:iam::xxxxxxxxxxxx:role/WSParticipantRole
export AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --out text)
export EKS_CONSOLE_IAM_ENTITY_ARN="arn:aws:iam::$AWS_ACCOUNT_ID:role/WSParticipantRole"
echo $EKS_CONSOLE_IAM_ENTITY_ARN
sed -i "s~EKS_CONSOLE_IAM_ENTITY_ARN~$EKS_CONSOLE_IAM_ENTITY_ARN~g" \
  gitops-system/tools-config/eks-console/aws-auth.yaml
sed -i "s~EKS_CONSOLE_IAM_ENTITY_ARN~$EKS_CONSOLE_IAM_ENTITY_ARN~g" \
  gitops-system/tools-config/eks-console/role-binding.yaml
