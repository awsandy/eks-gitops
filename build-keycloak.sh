tstart=$(date +%s)
time make fixed
time make cluster
time make addons
#sleep 30
#time make addons
time make observ
tend=$(date +%s)
runtime=$((tend - tstart))
echo "$com runtime $runtime seconds"