export CLUSTER_NAME=mgmt
cd ~/environment/gitops-system
# flux init
kubectl apply -f ./clusters/${CLUSTER_NAME}/flux-system/gotk-components.yaml
#
kubectl create secret generic flux-system -n flux-system \
    --from-file=identity=${HOME}/.ssh/gitops \
    --from-file=identity.pub=${HOME}/.ssh/gitops.pub \
    --from-file=known_hosts=${HOME}/.ssh/codecommit_known_hosts
#
#
# This has been updated with gitImplementation: libgit2
kubectl apply -f ./clusters/${CLUSTER_NAME}/flux-system/gotk-sync.yaml
#
echo "Track the progress of the Flux deployments using the Flux CLI. This may take >30 minutes due to exponential backoff, however this is only a one-time process."
flux get all
echo "You can watch this to see once it's ready by using:"
echo "watch -n 30 -d flux get all"