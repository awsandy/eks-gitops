tstart=$(date +%s)
echo "observ"
cd 06-observ-accel
terraform destroy --auto-approve 
echo "keycloak"
kubectl delete ns keycloak || true 
cd ../05-keycloak-grafana
terraform destroy --auto-approve
echo "gitops"
cd ../04-gitops
terraform destroy --auto-approve
echo "addons"
cd ../04-Addons
terraform destroy --auto-approve
echo "cluster"
cd ../03-Cluster
terraform destroy --auto-approve
echo "fixed resources"
cd ../01b-fixed-resources
terraform destroy --auto-approve
tend=$(date +%s)
runtime=$((tend - tstart))
echo "$com runtime $runtime seconds"