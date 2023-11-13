export HTTP_SERVICE_PORT=$(kubectl get --namespace keycloak -o jsonpath="{.spec.ports[?(@.name=='http')].port}" services keycloak)
export SERVICE_IP=$(kubectl get svc keycloak --namespace keycloak -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')
echo "http://${SERVICE_IP}:${HTTP_SERVICE_PORT}/"
echo "admin pw"
aws secretsmanager get-secret-value --secret-id oneobservabilityworkshop/keycloak --query "SecretString" --output text | jq -r '.["user-admin-password"]'
echo "editor pw"
aws secretsmanager get-secret-value --secret-id oneobservabilityworkshop/keycloak --query "SecretString" --output text | jq -r '.["user-editor-password"]'