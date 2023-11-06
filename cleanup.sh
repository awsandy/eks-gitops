cd 06-observ-accel
terraform destroy --auto-approve 
kubectl delete ns keycloak || true 
cd ../05-keycloak-grafana
terraform destroy --auto-approve
cd ../04-gitops
terraform destroy --auto-approve
cd ../03-Addons
terraform destroy --auto-approve
cd ../02-Cluster
terraform destroy --auto-approve
cd ../01b-fixed-resources
terraform destroy --auto-approve