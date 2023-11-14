https://github.com/aws-ia/terraform-aws-eks-blueprints-addons


on install: 
 --set webhook.securePort=10260 for helm chart (allows fargate and manahged nodes to work)
 https://github.com/cert-manager/cert-manager/issues/3237


https://github.com/aws-ia/terraform-aws-eks-blueprints-addons/blob/main/docs/addons/cert-manager.md

https://aws-quickstart.github.io/cdk-eks-blueprints/addons/cert-manager/
cert manager check:
kubectl cert-manager check api

kubectl get ClusterIssuer

IMPORTED-CERTS:
https://aws.amazon.com/blogs/containers/serve-distinct-domains-with-tls-powered-by-acm-on-amazon-eks/


## external secrets

https://aws.amazon.com/blogs/containers/leverage-aws-secrets-stores-from-eks-fargate-with-external-secrets-operator/
https://vinta.ws/code/amazon-eks-setup-kubernetes-external-secrets-with-aws-secret-manager.html

docs:

https://external-secrets.io/latest/introduction/getting-started/

