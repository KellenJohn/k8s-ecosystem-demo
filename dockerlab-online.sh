# prepare online dockerlab package
apk update
apk add curl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# download k3d/k3s
curl -s https://raw.githubusercontent.com/rancher/k3d/master/install.sh | bash

# install 
k3d cluster create demo --servers 1 --agents 3

# k3s 安裝
curl -sfL https://get.k3s.io | sh - 
# Check for Ready node, takes ~30 seconds 
k3s kubectl get node 

