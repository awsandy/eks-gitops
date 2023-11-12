#
cd ~/environment
openssl genrsa -out sealed-secrets-keypair.pem 4096
openssl req -new -x509 -key sealed-secrets-keypair.pem -out sealed-secrets-keypair-public.pem -days 3650
#
CRT=$(cat sealed-secrets-keypair-public.pem)
KEY=$(cat sealed-secrets-keypair.pem)
cat <<EoF >secret.json
{
  "crt": "$CRT",
  "key": "$KEY"
}
EoF
#
aws secretsmanager create-secret \
  --name sealed-secrets \
  --secret-string file://secret.json