terraform init
terraform apply -target="module.vpc" -auto-approve
terraform apply -target="module.eks" -auto-approve
terraform apply -auto-approve

build time circa: 18m
(vpc: 1m30s , cluster: 9m10s, fagate: 2m30s, Karpenter helm: )



EBS CSI: see

https://github.com/spacelift-io-blog-posts/Blog-Technical-Content/blob/master/eks-blueprints-terraform/main.tf

Tests in here:
https://spacelift.io/blog/bootstrap-complete-amazon-eks-clusters-with-eks-blueprints-for-terraform

