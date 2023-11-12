tstart=$(date +%s)
time make fixed
time make cluster
time make addons
time make grafana
time make observ
cd ../..
tend=$(date +%s)
runtime=$((tend - tstart))
echo "$com runtime $runtime seconds"