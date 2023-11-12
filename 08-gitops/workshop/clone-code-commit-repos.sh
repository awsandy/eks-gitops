#!/bin/bash
cd ~/environment
git config --global init.defaultBranch main
GIT_REPOS=$(aws codecommit list-repositories --output text --query 'repositories[*].repositoryName')
repos=( gitops-system gitops-workloads product-catalog-api-manifests product-catalog-fe-manifests )
for repo in "${repos[@]}"; do
  if [[ "$GIT_REPOS" == *"$repo"* ]]; then
    echo "Repository $repo found."
  else
    echo "Repository $repo not found."
    echo "Creating repository $repo..."
    aws codecommit create-repository \
      --repository-name $repo
    echo "SSH Clone URL for user gitops"
    echo " - ssh://${SSH_KEY_ID_GITOPS}@git-codecommit.${AWS_REGION}.amazonaws.com/v1/repos/$repo"
  fi
done
export REPO_PREFIX=ssh://$SSH_PUB_KEY_ID@git-codecommit.$AWS_REGION.amazonaws.com/v1/repos
printf "\n%s" "export REPO_PREFIX=$REPO_PREFIX" >> ~/.bash_profile
git clone -q $REPO_PREFIX/gitops-system
git clone -q $REPO_PREFIX/gitops-workloads
git clone -q $REPO_PREFIX/product-catalog-api-manifests
git clone -q $REPO_PREFIX/product-catalog-fe-manifests