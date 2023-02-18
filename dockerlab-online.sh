# prepare online dockerlab package
apk update \
apk add curl
# download k3d/k3s
curl -s https://raw.githubusercontent.com/rancher/k3d/master/install.sh | bash

# kubectl install
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"  \
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# install 
k3d cluster create demo --servers 1 --agents 3 \
kubectl get node 

# ArgoCD
kubectl create namespace argocd \ 
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml \
kubectl get pods -n argocd
