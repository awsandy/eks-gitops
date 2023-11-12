cd ~/environment
cp multi-cluster-gitops/initial-setup/config/mgmt-cluster-eksctl.yaml .
sed -i "s/AWS_REGION/$AWS_REGION/g" mgmt-cluster-eksctl.yaml     
eksctl create cluster -f mgmt-cluster-eksctl.yaml