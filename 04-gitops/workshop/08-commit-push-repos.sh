#
cd ~/environment/gitops-system
git add .
git commit -m "initial commit"
git branch -M main
git push --set-upstream origin main
#
cd ~/environment/gitops-workloads
git add .
git commit -m "initial commit"
git branch -M main
git push --set-upstream origin main