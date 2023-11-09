echo "Install flux cli"
curl -s https://fluxcd.io/install.sh | sudo bash
echo "Install kubectl v1.27.7"
curl -LO https://dl.k8s.io/release/v1.27.7/bin/linux/amd64/kubectl
#curl --silent -LO https://dl.k8s.io/release/v1.24.14/bin/linux/amd64/kubectl >/dev/null
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl >/dev/null
kubectl completion bash >>~/.bash_completion
echo "Install eksctl"
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp >/dev/null
sudo mv -v /tmp/eksctl /usr/local/bin >/dev/null
eksctl completion bash >>~/.bash_completion
# auth console:
c9builder=$(aws cloud9 describe-environment-memberships --environment-id=$C9_PID | jq -r '.memberships[].userArn')
if echo ${c9builder} | grep -q user; then
	rolearn=${c9builder}
        echo Role ARN: ${rolearn}
elif echo ${c9builder} | grep -q assumed-role; then
        assumedrolename=$(echo ${c9builder} | awk -F/ '{print $(NF-1)}')
        rolearn=$(aws iam get-role --role-name ${assumedrolename} --query Role.Arn --output text) 
        echo Role ARN: ${rolearn}
fi
cn=$(aws eks list-clusters --query clusters --output text)
eksctl create iamidentitymapping --cluster $cn --arn ${rolearn} --group system:masters --username admin