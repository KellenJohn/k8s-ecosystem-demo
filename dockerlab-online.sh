# prepare online dockerlab package
apk update \
apk add curl \
# download k3d/k3s
curl -s https://raw.githubusercontent.com/rancher/k3d/master/install.sh | bash

# kubectl install
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"  \
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# install 
k3d cluster create demo --servers 1 --agents 3 \
kubectl get node 

# ArgoCD
kubectl create namespace argocd 
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl get pods -n argocd

# Argo Cli  
# https://argo-cd.readthedocs.io/en/stable/cli_installation/
curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
sudo install -m 555 argocd-linux-amd64 /usr/local/bin/argocd
rm argocd-linux-amd64

##############################################################################################
# Good
https://icloudnative.io/posts/getting-started-with-argocd/
https://www.readfog.com/a/1676342497667813376
https://rammusxu.github.io/2019/07/16/GitOps-Argo-CD-Note/
https://blog.51cto.com/u_15315026/5078430
# Downward API
https://www.twblogs.net/a/61046f82a90470e2175feb83
https://kubernetes.io/zh-cn/docs/tasks/inject-data-application/downward-api-volume-expose-pod-information/

https://stackoverflow.com/questions/67262769/access-argocd-server
https://stackoverflow.com/questions/71030111/how-to-login-to-argocd-cli-non-interactive-in-ci-like-github-actions

argocd login 10.43.62.196:31214 --username admin --password LA-a5ik06Bip74qt --insecure

kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'

argoPass=$(kubectl -n argocd get secret argocd-initial-admin-secret \
    -o jsonpath="{.data.password}" | base64 -d)

argocd login --insecure --grpc-web k3s_master:32761 --username admin \
    --password $argoPass
    
#     
argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
# Obtaining the ArgoCD server's hostname is also no big deal using:

kubectl get service argocd-server -n argocd --output=jsonpath='{.status.loadBalancer.ingress[0].hostname}'
argocd login $(kubectl get service argocd-server -n argocd --output=jsonpath='{.status.loadBalancer.ingress[0].hostname}') \
       --username admin --password $(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo) --insecure
    
