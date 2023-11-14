echo -n 'KEYID' > ./access-key
echo -n 'SECRETKEY' > ./secret-access-key
kubectl create secret generic awssm-secret --from-file=./access-key --from-file=./secret-access-key
kubectl apply -f basic-secret-store.yaml
kubectl apply -f "basic-external-secret.yaml
kubectl describe externalsecret example
