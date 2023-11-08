cd ~/environment
aws iam create-user \
  --user-name gitops

cat >gitops-policy.json <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "codecommit:GitPull",
        "codecommit:GitPush"
      ],
      "Resource": "arn:aws:codecommit:${AWS_REGION}:${ACCOUNT_ID}:*"
    }
  ]
}
EOF

POLICY_ARN=$(aws iam create-policy \
  --policy-name "gitops-policy" \
  --description "IAM policy for user gitops." \
  --policy-document file://gitops-policy.json \
  --query 'Policy.Arn' \
  --output text)

aws iam attach-user-policy \
  --user-name gitops \
  --policy-arn "${POLICY_ARN}"

#####

cd ~/.ssh
ssh-keygen -t rsa -b 4096 -N "" -C "gitops@<yourcompany.com>" -f gitops
#
cd ~/.ssh
SSH_KEY_ID_GITOPS=$(aws iam upload-ssh-public-key \
  --user-name gitops \
  --ssh-public-key-body file://gitops.pub \
    --query 'SSHPublicKey.SSHPublicKeyId' \
    --output text)
echo "SSH key id of user gitops: ${SSH_KEY_ID_GITOPS}"
#
cat >~/.ssh/config <<EOF 
Host git-codecommit.*.amazonaws.com
  User ${SSH_KEY_ID_GITOPS}
  IdentityFile ~/.ssh/gitops
EOF
# create repos
cd ~/environment
git config --global init.defaultBranch main
repos=( gitops-system gitops-workloads )
for repo in "${repos[@]}"; do
  aws codecommit create-repository \
    --repository-name $repo
  
  echo "SSH Clone URL for user gitops"
  echo " - ssh://${SSH_KEY_ID_GITOPS}@git-codecommit.${AWS_REGION}.amazonaws.com/v1/repos/$repo"
done
#
export REPO_PREFIX=ssh://${SSH_KEY_ID_GITOPS}@git-codecommit.${AWS_REGION}.amazonaws.com/v1/repos
# glone repos locally
git clone $REPO_PREFIX/gitops-system
git clone $REPO_PREFIX/gitops-workloads
#
cd ~/environment
ssh-keyscan \
  -t rsa \
  git-codecommit.${AWS_REGION}.amazonaws.com \
  > ~/.ssh/codecommit_known_hosts 2>/dev/null
#
cd ~/environment
kubectl create secret generic flux-system -n flux-system \
    --from-file=identity=${HOME}/.ssh/gitops \
    --from-file=identity.pub=${HOME}/.ssh/gitops.pub \
    --from-file=known_hosts=${HOME}/.ssh/codecommit_known_hosts \
    --dry-run=client \
    --output=yaml \
    >git-creds-system.yaml