Start with "Amazon EKS workshop" studio
https://studio.us-east-1.prod.workshops.aws/workshops/public/39146514-f6d5-41cb-86ef-359f9d2f7265

30G / - no resize required
terraform 1.4.1 - need 1.6.2
aws cli 2.13 ok
jq ok
kubectl 1.23 - needs upgrading
eksctl 0.144


```bash
git clone https://github.com/awsandy/eks-gitops.git
```


## Create and fix Route53 zone
```bash
cd 01a-dns
terraform init
terraform apply -auto-approve
```


```bash
cd ~/environment
time eksctl delete cluster  --name eks-workshop     # ~8min
fsid=$(aws efs describe-file-systems --query FileSystems[].FileSystemId --output text)
for mtid in $(aws efs describe-mount-targets --file-system-id $fsid --query MountTargets[].MountTargetId --output text);do
echo $mtid
aws efs delete-mount-target --mount-target-id $mtid
done
aws efs delete-file-system --file-system-id $fsid
dbi=$(aws rds describe-db-instances --query DBInstances[].DBInstanceIdentifier --output text)
aws rds delete-db-instance --db-instance-identifier $dbi --skip-final-snapshot 
```




Don't provison cluster with eksctl - but rather TF
from my VPC lattice lab4 
vpc modules 
eks module



terraform init
terraform apply -target="module.vpc" -auto-approve
terraform apply -target="module.eks" -auto-approve
terraform apply -auto-approve


use-cluster $EKS_CLUSTER_NAME

https://catalog.workshops.aws/eks-blueprints-terraform/en-US/061-autoscaling-karpenter/1-enable-karpenter









https://github.com/aws-ia/terraform-aws-eks-blueprints-addons

https://fluxcd.io/blog/2022/09/how-to-gitops-your-terraform/

flux bootstrap command:  - 
https://www.eksworkshop.com/docs/automation/gitops/flux/cluster_bootstrap

equiv in terraform:
https://registry.terraform.io/providers/fluxcd/flux/latest/docs/guides/install-helm-release

EKS Blueprints workshop
https://catalog.workshops.aws/eks-blueprints-terraform/en-US/030-provision-eks-cluster/02-eks-cluster-module/1-configure-module
https://catalog.workshops.aws/eks-blueprints-terraform/en-US/061-autoscaling-karpenter/6-cost-spot

EKS Security
https://catalog.workshops.aws/containersecurity/en-US/module1

EKS Troubleshooting
https://catalog.workshops.aws/eks-troubleshooting/en-US/getting-started


Gitops flux:
https://catalog.us-east-1.prod.workshops.aws/workshops/20f7b273-ed55-411f-8c9c-4dc9e5ff8677/en-US/lab-01-workshop-setup




https://aws.amazon.com/blogs/opensource/authenticating-with-amazon-managed-grafana-using-open-source-keycloak-on-amazon-eks/

https://aws.amazon.com/blogs/opensource/configure-keycloak-on-amazon-elastic-kubernetes-service-amazon-eks-using-terraform/

https://github.com/aws-samples/configure-keycloak-on-eks-using-terraform




