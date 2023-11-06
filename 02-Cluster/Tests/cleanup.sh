kubectl delete -f stateful.yaml
pn=$(kubectl get pvc -o json | jq -r '.items[].metadata.name' | grep example)
kubectl delete pvc $pn