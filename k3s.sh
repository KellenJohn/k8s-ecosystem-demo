# k3s Deployment 
# Curl
curl -s https://raw.githubusercontent.com/rancher/k3d/master/install.sh | bash
k3d cluster create demo --servers 1 --agents 3
curl -sfL http://rancher-mirror.cnrancher.com/k3s/k3s-install.sh | INSTALL_K3S_MIRROR=cn sh -
# Install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
