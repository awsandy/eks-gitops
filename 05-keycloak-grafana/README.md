https://aws.amazon.com/blogs/opensource/authenticating-with-amazon-managed-grafana-using-open-source-keycloak-on-amazon-eks/

https://aws.amazon.com/blogs/opensource/configure-keycloak-on-amazon-elastic-kubernetes-service-amazon-eks-using-terraform/

https://github.com/aws-samples/configure-keycloak-on-eks-using-terraform


Extenal DNS service - point to our public PHZ

ACM public cert for keycloak.demo.awsandy.people.aws.dev

Troubleshoot:

check:
dig 021319709832.awsandy.people.aws.dev NS +short

returns expected NS

check:
dig +short _64f29c4286c3ad21916aa544753e6a8e.keycloak.021319709832.awsandy.people.aws.dev

returns expected values


postgres:

kubectl -n keycloak get pvc

kubectl -n keycloak describe pvc (postgres looking for gp2)



kubectl get storageclasses.storage.k8s.io 
gp2 (default)   kubernetes.io/aws-ebs   Delete          WaitForFirstConsumer   false




nn=$(kubectl get node -l karpenter.sh/provisioner-name |  awk '{print $1}' | tail -1)
ii=$(kubectl get node $nn -o json | jq -r ".spec.providerID" | cut -d \/ -f5)
echo $ii