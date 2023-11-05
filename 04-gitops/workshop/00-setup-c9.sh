#curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
#unzip awscliv2.zip
#sudo ./aws/install
#
aws cloud9 update-environment  --environment-id $C9_PID --managed-credentials-action DISABLE
rm -vf ${HOME}/.aws/credentials
#
aws sts get-caller-identity --query Arn | grep gitops-workshop -q && echo "IAM role valid" || echo "IAM role NOT valid"
#
sudo curl --silent --location -o /usr/local/bin/yq https://github.com/mikefarah/yq/releases/download/v4.24.5/yq_linux_amd64
sudo chmod +x /usr/local/bin/yq
#
export ACCOUNT_ID=$(aws sts get-caller-identity --output text --query Account)
export AWS_REGION=$(curl -s 169.254.169.254/latest/dynamic/instance-identity/document | yq -e '.region')
echo $ACCOUNT_ID:$AWS_REGION
echo "export ACCOUNT_ID=${ACCOUNT_ID}" | tee -a ~/.bash_profile
echo "export AWS_REGION=${AWS_REGION}" | tee -a ~/.bash_profile
aws configure set default.region ${AWS_REGION}
aws configure get default.region
#
echo 
export EKS_CONSOLE_IAM_ENTITY_ARN=<IAM user/role ARN>
echo "export EKS_CONSOLE_IAM_ENTITY_ARN=${EKS_CONSOLE_IAM_ENTITY_ARN}" | tee -a ~/.bash_profile
#
echo "https://docs.aws.amazon.com/cloud9/latest/user-guide/move-environment.html#move-environment-resize"
echo "bash resize.sh 30"
#
# echo "Install Tools ...."
sudo curl --silent --location -o /usr/local/bin/kubectl \
   https://s3.us-west-2.amazonaws.com/amazon-eks/1.24.7/2022-10-31/bin/linux/amd64/kubectl

sudo chmod +x /usr/local/bin/kubectl
#
curl -s https://fluxcd.io/install.sh | sudo bash
#
wget https://github.com/bitnami-labs/sealed-secrets/releases/download/v0.19.4/kubeseal-0.19.4-linux-amd64.tar.gz
tar xfz kubeseal-0.19.4-linux-amd64.tar.gz
sudo install -m 755 kubeseal /usr/local/bin/kubeseal
#
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update
sudo apt install gh
#
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin
#
cd ~/environment
git clone https://github.com/aws-samples/multi-cluster-gitops.git
