kubectl get pods -n cert-manager  
kubectl cert-manager check api
kubectl apply -f self-hosted-cert.yaml
kubectl get clusterissuers -o wide selfsigned-cluster-issuer
kubectl apply -f cert2.yaml
kubectl get certificate -o wide
kubectl get secret example-secret