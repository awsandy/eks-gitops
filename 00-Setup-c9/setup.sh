curl -s https://fluxcd.io/install.sh | sudo bash
echo "Install kubectl v1.24.12"
curl -LO https://dl.k8s.io/release/v1.27.7/bin/linux/amd64/kubectl
#curl --silent -LO https://dl.k8s.io/release/v1.24.14/bin/linux/amd64/kubectl >/dev/null
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl >/dev/null
kubectl completion bash >>~/.bash_completion