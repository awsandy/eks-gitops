tstart=$(date +%s)
echo "observ"
cd 05-observw-eks
terraform destroy --auto-approve 
echo "keycloak"
kubectl delete ns keycloak || true 
cd ../05-keycloak-grafana
terraform destroy --auto-approve
echo "gitops"
cd ../04-gitops
terraform destroy --auto-approve
echo "addons"
cd ../03-Addons
terraform destroy --auto-approve
echo "cluster"
cd ../02-Cluster
kubectl delete deployment inflate
kubectl delete Provisioner default -n karpenter 
terraform destroy --auto-approve
echo "fixed resources"
cd ../01b-fixed-resources
terraform destroy --auto-approve
tend=$(date +%s)
runtime=$((tend - tstart))
echo "$com runtime $runtime seconds"