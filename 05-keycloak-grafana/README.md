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


https://spacelift.io/blog/bootstrap-complete-amazon-eks-clusters-with-eks-blueprints-for-terraform



-------

APP VERSION: 22.0.5

** Please be patient while the chart is being deployed **

Keycloak can be accessed through the following DNS name from within your cluster:

    keycloak.keycloak.svc.cluster.local (port 80)

To access Keycloak from outside the cluster execute the following commands:

1. Get the Keycloak URL and associate its hostname to your cluster external IP:

   export CLUSTER_IP=$(minikube ip) # On Minikube. Use: `kubectl cluster-info` on others K8s clusters
   echo "Keycloak URL: http://keycloak.021319709832.awsandy.people.aws.dev/"
   echo "$CLUSTER_IP  keycloak.021319709832.awsandy.people.aws.dev" | sudo tee -a /etc/hosts

2. Access Keycloak using the obtained URL.
3. Access the Administration Console using the following credentials:

  echo Username: admin
  echo Password: $(kubectl get secret --namespace keycloak keycloak -o jsonpath="{.data.admin-password}" | base64 -d)


   kubectl get ingress -n keycloak   
   echo $(kubectl get secret --namespace keycloak keycloak -o jsonpath="{.data.admin-password}" | base64 -d)


----------------------

Sign in problems

goto keycloak dashboard:
switch to "keycloak-blog" - top left
Sessions  - dlete as necessary 
login again

