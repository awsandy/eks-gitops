terraform init
terraform apply -target="module.vpc" -auto-approve
terraform apply -target="module.eks" -auto-approve
terraform apply -auto-approve

build time circa: 18m
(vpc: 1m30s , cluster: 9m10s, fagate: 2m30s, Karpenter helm: )

