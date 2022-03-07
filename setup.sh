#!/usr/bin/env bash

: <<'###BLOCK-COMMENT'
Installing different tools
Profile used: ~/.bash_rc
# Tools will be install
    1. curl, nettools, wget, apt-transport-https, snap
    2. git
    3. vim
    4. xclip
    5. python3-pip
    6. vscode
    7. kubernet, minikube, docker
    8. nomachine
    9. postman
    10. vim vimrc create
###BLOCK-COMMENT

sudo apt-get update -y

echo 'installing curl' 
sudo apt install -y curl wget apt-transport-https net-tools

sleep 5
echo 'installing git' 
sudo apt install git -y

sleep 5
echo 'installing tool to handle clipboard via CLI'
sudo apt-get install xclip -y
export alias pbcopy='xclip -selection clipboard'
export alias pbpaste='xclip -selection clipboard -o'
source ~/.bashrc

echo 'installing vim'
sudo apt install vim -y
clear

sleep 5
echo 'installing python-3 pip'
sudo apt-get install python3-setuptools
sudo python3 -m easy_install install pip
python3 -m pip --version

sleep 5
echo 'installing code'
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt-get install apt-transport-https -y
sudo apt-get update
sudo apt-get install code -y # or code-insiders

sleep 5
echo 'Install kubectl command line utility:'
sudo apt-get update && sudo apt-get install -y apt-transport-https
sudo apt-get install software-properties-common -y
sudo apt-get install curl -y
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl
# Enable tab completion
echo "source <(kubectl completion bash)" >> ~/.bashrc

echo 'Install minikube'
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && sudo install minikube-linux-amd64 /usr/local/bin/minikube

sleep 5
echo 'Install Docker 18.06 (Kubernetes does not support newer version of Docker yet)' 
sudo apt-get remove docker docker-engine docker.io
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update && sudo apt-get install docker-ce=18.06.0~ce~3-0~ubuntu -y
sudo systemctl start docker
sudo systemctl enable docker

echo 'Add your user to the user groups so you dont have to "sudo" everytime:'
sudo groupadd docker
sudo usermod -aG docker $USER 
sudo groupadd kubectl
sudo usermod -aG kubectl $USER
sudo groupadd minikube
sudo usermod -aG minikube $USER
chmod 777 /var/run/docker.sock
source ~/.bashrc
docker --version
docker run hello-world

echo 'getting Minikube started'
minikube start --driver docker

echo 'Updating permissions' 
sudo chown -R $USER $HOME/.kube
sudo chgrp -R $USER $HOME/.kube
sudo chown -R $USER $HOME/.minikube
sudo chgrp -R $USER $HOME/.minikube


echo 'Check the addons list and enalbe Ingress if you are going to be using ingress controllers'
minikube addons list
minikube addons enable ingress

sleep 5
echo 'installing nomachine'
wget https://download.nomachine.com/download/7.7/Linux/nomachine_7.7.4_1_amd64.deb
sudo dpkg -i nomachine_7.7.4_1_amd64.deb
sudo apt-get install -f

echo 'installing postman'
sudo snap install postman

echo 'Updating vmrc file'
cat <<EOT >> ~/.vimrc 
"turn on syntax highlighting
syntax on

" ================ Indentation ======================
set tabstop=4           " number of visual spaces per TAB
set softtabstop=4       " number of spaces in tab when editing
set expandtab           " tabs are spaces
set number              " show line numbers
set showcmd             " show command in bottom bar
set cursorline          " highlight current line
filetype indent on      " load filetype-specific indent files
set wildmenu            " visual autocomplete for command menu
set lazyredraw          " redraw only when we need to.
set showmatch           " highlight matching [{()}]
set incsearch           " search as characters are entered
set hlsearch            " highlight matches

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·

" ================ Turn Off Swap Files ==============
set noswapfile
set nobackup
set nowb

EOT

