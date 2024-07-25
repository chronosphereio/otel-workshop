#!/bin/bash
#Install dependencies

#export PATH
#
export PATH=$PATH

echo "######################################################## Installing Kind ########################################################"

# For Intel Macs
[ $(uname -m) = x86_64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.23.0/kind-darwin-amd64
# For M1 / ARM Macs
[ $(uname -m) = arm64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.23.0/kind-darwin-arm64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind
echo "######################################################## Kind Install Complete ########################################################"

echo  "######################################################## Installing Helm ########################################################"
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
echo "######################################################## Helm Install Complete ########################################################"

echo "######################################################## Installing Homebrew ########################################################"

echo "######################################################## Homebrew is required for installing Docker Desktop on Mac ########################################################"

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

echo "######################################################## Homebrew installation complete ########################################################"

echo "######################################################## Installing Docker Desktop with homebrew cask ########################################################"

brew cask install docker

echo "######################################################## Docker Desktop installation complete ########################################################"

echo "######################################################## Installing Kubectl ########################################################"

# For Intel Macs
[ $(uname -m) = x86_64 ] && curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/darwin/amd64/kubectl"
# For M1 / ARM Macs
[ $(uname -m) = arm64 ] && curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/darwin/arm64/kubectl"
#Make executable
chmod +x ./kubectl
#Move to system PATH
sudo mv ./kubectl /usr/local/bin/kubectl
sudo chown root: /usr/local/bin/kubectl

echo "######################################################## kubectl has been installed! ########################################################"

echo "######################################################## Dependency installation complete ########################################################"
