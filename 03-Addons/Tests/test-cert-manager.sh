kubectl get pods -n cert-manager  
kubectl cert-manager check api
kubectl apply -f self-hosted-cert.yaml
kubectl get clusterissuers -o wide selfsigned-cluster-issuer
kubectl apply -f cert2.yaml
kubectl get certificate -o wide
kubectl get secret example-secret
# acm not relevant as certs are internal to cert-manager
#aws acm list-certificates --include keyTypes=
#aws acm list-certificates
# imported certs:
# openssl req -new -x509 -sha256 -nodes -newkey rsa:4096 -keyout private_rabbit.key -out certificate_rabbit.crt -subj "/CN=rabbit.local"
# aws acm import-certificate --certificate fileb://certificate_rabbit.crt --private-key fileb://private_rabbit.key
# aws acm list-certificates --include keyTypes=RSA_4096