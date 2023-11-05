#!/bin/bash
cd ~/.ssh
ssh-keygen -q -t rsa -b 4096 -N '' -C gitops -f gitops <<<y >/dev/null 2>&1
chmod 600 gitops*
export SSH_PUB_KEY_ID=$(aws iam upload-ssh-public-key \
  --user-name gitops \
  --ssh-public-key-body file://gitops.pub \
  --query 'SSHPublicKey.SSHPublicKeyId' \
  --output text)
echo "Sleeing for 2 minutes"
sleep 120
echo "SSH key id of user gitops: $SSH_PUB_KEY_ID"
printf "\n%s" "export SSH_PUB_KEY_ID=$SSH_PUB_KEY_ID" >> ~/.bash_profile
echo "Generating sshd config file for AWS CodeCommit user..."
cat >config <<EoF
Host git-codecommit.*.amazonaws.com
  User $SSH_PUB_KEY_ID
  IdentityFile $HOME/.ssh/gitops
EoF
chmod 600 config
echo "Generating known_hosts for AWS CodeCommit service endpoints..."
ssh-keyscan \
  -t rsa \
  git-codecommit.$AWS_REGION.amazonaws.com \
  > codecommit_known_hosts 2>/dev/null
cp codecommit_known_hosts known_hosts
chmod 600 codecommit_known_hosts known_hosts
kubectl create secret generic flux-system -n flux-system \
  --from-file=identity=$HOME/.ssh/gitops \
  --from-file=identity.pub=$HOME/.ssh/gitops.pub \
  --from-file=known_hosts=$HOME/.ssh/codecommit_known_hosts \
  --dry-run=client \
  --output=yaml \
  >$HOME/environment/git-creds-system.yaml