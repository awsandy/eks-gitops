tstart=$(date +%s)
echo "observ"
cd 05-observw-eks
terraform destroy --auto-approve 
echo "keycloak"
kubectl delete ns keycloak || true 
cd ../05-keycloak-grafana
terraform destroy --auto-approve
echo "gitops"
cd ../04-observw-grafana-keycloak
terraform destroy --auto-approve
echo "addons"
cd ../03-Addons
terraform destroy --auto-approve
echo "cluster"
cd ../02-Cluster
kubectl delete deployment inflate || true
kubectl delete ns karpenter || true
kubectl delete deployment inflate || true
kubectl delete Provisioner default -n karpenter || true
terraform destroy --auto-approve
echo "fixed resources"
cd ../01b-fixed-resources
terraform destroy --auto-approve
tend=$(date +%s)
runtime=$((tend - tstart))
echo "$com runtime $runtime seconds"