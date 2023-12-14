tstart=$(date +%s)
#time terraform destroy -target="module.eks_blueprints_addons" -auto-approve
time terraform destroy -target="module.eks" -auto-approve
time terraform destroy -target="module.vpc" -auto-approve
time terraform destroy -auto-approve
tend=$(date +%s)
runtime=$((tend - tstart))
echo "$com runtime $runtime seconds"