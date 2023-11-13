acc=$(aws sts get-caller-identity --query Account --output text)
pa="arn:aws:iam::$acc:policy/OneObservabilityWorkshopKeycloakSecretStorePolicy"
echo $pa
aws iam delete-policy --policy-arn $pa
ENV_BASE_DIR=~/environment     # Change this if you executed the `envsetup.sh` script in a different location.
CLUSTER_NAME=$(aws eks list-clusters | jq -r '.clusters[]')
WORKSPACE_NAME=demo-amg      # Change this if you specified a different name for the AMG workspace.
KEYCLOAK_NAMESPACE=keycloak
KEYCLOAK_REALM_AMG=amg
SETUP_SCRIPT_DIR="${ENV_BASE_DIR}/eks-gitops/04-observw-grafana-keycloak"
if [ ! -f "${SETUP_SCRIPT_DIR}/keycloak-setup.sh" ]; then
  echo "ERROR: Environment variable ENV_BASE_DIR is set to '${ENV_BASE_DIR}'"
  echo "ERROR: Script '${SETUP_SCRIPT_DIR}/keycloak-setup.sh' not found."
  echo 'ERROR: Check if ENV_BASE_DIR is pointing to the location where the envsetup.sh script was executed.'
else
  cd $SETUP_SCRIPT_DIR
  ./keycloak-setup.sh \
    --cluster-name $CLUSTER_NAME \
    --workspace-name $WORKSPACE_NAME \
    --keycloak-namespace $KEYCLOAK_NAMESPACE \
    --keycloak-realm $KEYCLOAK_REALM_AMG
fi