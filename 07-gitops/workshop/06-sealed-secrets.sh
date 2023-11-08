kubeseal --cert sealed-secrets-keypair-public.pem --format yaml <git-creds-system.yaml >git-creds-sealed-system.yaml
cp git-creds-sealed-system.yaml gitops-system/clusters-config/template/secrets/git-secret.yaml
cp git-creds-system.yaml git-creds-workloads.yaml
yq e '.metadata.name="gitops-workloads"' -i git-creds-workloads.yaml
kubeseal --cert sealed-secrets-keypair-public.pem --format yaml <git-creds-workloads.yaml >git-creds-sealed-workloads.yaml
cp git-creds-sealed-workloads.yaml gitops-system/workloads/template/git-secret.yaml