cp -r eks-multi-cluster-gitops/repos/gitops-system/* gitops-system/
cp -r eks-multi-cluster-gitops/repos/gitops-workloads/* gitops-workloads/
#
# echo "Update REGION"
sed -i "s/AWS_REGION/$AWS_REGION/g" \
   gitops-system/clusters-config/template/def/eks-cluster.yaml \
   gitops-system/tools-config/external-secrets/sealed-secrets-key.yaml
#
echo "Update references to GitRepository URLs"
echo $REPO_PREFIX
sed -i "s~REPO_PREFIX~$REPO_PREFIX~g" \
  gitops-system/workloads/template/git-repo.yaml
#
sed -i "s~REPO_PREFIX~$REPO_PREFIX~g" \
  gitops-system/clusters/mgmt/flux-system/gotk-sync.yaml \
  gitops-system/clusters/template/flux-system/gotk-sync.yaml
sed -i "s~REPO_PREFIX~$REPO_PREFIX~g" \
  gitops-workloads/template/app-template/git-repo.yaml
#
echo "Patch GitRepository for AWS CodeCommit"
#
LIBGIT2='. |= (with(select(.kind=="GitRepository");.spec |= ({"gitImplementation":"libgit2"}) + .))'
echo $LIBGIT2
yq -i e "$LIBGIT2" \
  gitops-system/workloads/template/git-repo.yaml
#
yq -i e "$LIBGIT2" \
  gitops-system/clusters/mgmt/flux-system/gotk-sync.yaml
yq -i e "$LIBGIT2" \
  gitops-system/clusters/template/flux-system/gotk-sync.yaml
#
# workloads
#
yq -i e "$LIBGIT2" \
  gitops-workloads/template/app-template/git-repo.yaml