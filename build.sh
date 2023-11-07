tstart=$(date +%s)
time make fixed
time make cluster
time make addons
sleep 30
time make addons
time make observ
cd 05-keycloak-grafana/blog
./05a*
./05b*
./06*
./07*
cd ../..
tend=$(date +%s)
runtime=$((tend - tstart))
echo "$com runtime $runtime seconds"