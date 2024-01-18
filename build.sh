tstart=$(date +%s)
make fixed
time make net
time make cluster
time make addons
time make grafana
time make observ
cd ../..
tend=$(date +%s)
runtime=$((tend - tstart))
echo "$com runtime $runtime seconds"