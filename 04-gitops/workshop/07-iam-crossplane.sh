export MGMT_CLUSTER_INFO=$(aws eks describe-cluster --name mgmt) 
export CLUSTER_ARN=$(echo $MGMT_CLUSTER_INFO | yq '.cluster.arn')
export OIDC_PROVIDER_URL=$(echo $MGMT_CLUSTER_INFO | yq '.cluster.identity.oidc.issuer')
export OIDC_PROVIDER=${OIDC_PROVIDER_URL#'https://'}
#
cd ~/environment
envsubst \
  < multi-cluster-gitops/initial-setup/config/crossplane-role-trust-policy-template.json \
  > crossplane-role-trust-policy.json
#
CROSSPLANE_IAM_ROLE_ARN=$(aws iam create-role \
  --role-name crossplane-role \
  --assume-role-policy-document file://crossplane-role-trust-policy.json \
  --output text \
  --query "Role.Arn")
# cd ~/environment
envsubst \
< multi-cluster-gitops/initial-setup/config/crossplane-role-permission-policy-template.json \
> crossplane-role-permission-policy.json

CROSSPLANE_IAM_POLICY_ARN=$(aws iam create-policy \
   --policy-name crossplane-policy \
   --policy-document file://crossplane-role-permission-policy.json \
   --output text \
   --query "Policy.Arn")

aws iam attach-role-policy --role-name crossplane-role --policy-arn ${CROSSPLANE_IAM_POLICY_ARN}
#
kubectl create ns flux-system
kubectl create configmap cluster-info -n flux-system \
  --from-literal=AWS_REGION=${AWS_REGION} \
  --from-literal=ACCOUNT_ID=${ACCOUNT_ID} \
  --from-literal=CLUSTER_ARN=${CLUSTER_ARN} \
  --from-literal=OIDC_PROVIDER=${OIDC_PROVIDER}

