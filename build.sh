tstart=$(date +%s)
time make fixed
time make cluster
time make addons
time make grafana
cd 05-keycloak-grafana/blog
./05a*
./05b*
./06*
./07*
cd ../..
time make observ
tend=$(date +%s)
runtime=$((tend - tstart))
echo "$com runtime $runtime seconds"