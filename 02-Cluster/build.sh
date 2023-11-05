tstart=$(date +%s)
time terraform apply -target="module.vpc" -auto-approve
time terraform apply -target="module.eks" -auto-approve
time terraform apply -auto-approve
tend=$(date +%s)
runtime=$((tend - tstart))
echo "$com runtime $runtime seconds"