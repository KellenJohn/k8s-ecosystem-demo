# prepare online dockerlab package
apk update
apk add curl
# kubectl install
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# download k3d/k3s
curl -s https://raw.githubusercontent.com/rancher/k3d/master/install.sh | bash

# install 
k3d cluster create demo --servers 1 --agents 3
kubectl get node 
