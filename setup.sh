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
    6. vscode and extensions
    7. kubernet, minikube, docker
    8. nomachine
    9. postman
    10. vim vimrc create
###BLOCK-COMMENT

banner() {
    msg="# $* #"
    edge=$(echo "$msg" | sed 's/./#/g')
    echo "$edge"
    echo "$msg"
    echo "$edge"
}

sudo apt-get update -y

banner "Installing curl, wget, net-tools, snap"
sudo apt install -y curl wget apt-transport-https net-tools

sleep 5
banner "Installing git"
sudo apt install git -y

sleep 5
banner "Installing tool to handle clipboard via CLI"
sudo apt-get install xclip -y
export alias pbcopy='xclip -selection clipboard'
export alias pbpaste='xclip -selection clipboard -o'
source ~/.bashrc

banner "Installing vim"
sudo apt install vim -y

sleep 5
banner "Installing python-3 pip"
sudo apt-get install python3-setuptools
sudo python3 -m easy_install install pip
python3 -m pip --version

sleep 5
banner "Installing vs code"
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt-get install apt-transport-https -y
sudo apt-get update
sudo apt-get install code -y # or code-insiders

sleep 5
banner "Installing Docker"
# Update the apt package index and install packages to allow apt to use a repository over HTTPS:
sudo apt-get purge docker-ce docker-ce-cli containerd.io
sudo apt-get update
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Add Docker’s official GPG key:
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  
banner "Install Docker Engine"
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io -y

# To run Docker without root privileges, see Run the Docker daemon as a non-root user (Rootless mode).
sudo groupadd docker
sudo usermod -aG docker $USER

echo 'Configure Docker to start on boot'
sudo systemctl enable docker.service
sudo systemctl enable containerd.service
source ~/.bashrc
docker --version
docker run hello-world


banner "Install minikube"
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && sudo install minikube-linux-amd64 /usr/local/bin/minikube
sudo groupadd minikube
sudo usermod -aG minikube $USER
minikube start


banner "install kubernets"
sudo snap install kubectl --classic
kubectl cluster-info
echo 'Add your user to the user groups so you dont have to "sudo" everytime:'
sudo groupadd kubectl
sudo usermod -aG kubectl $USER

echo 'Updating permissions' 
sudo chown -R $USER $HOME/.kube
sudo chgrp -R $USER $HOME/.kube
sudo chown -R $USER $HOME/.minikube
sudo chgrp -R $USER $HOME/.minikube


sleep 5
banner "installing nomachine"
wget https://download.nomachine.com/download/7.7/Linux/nomachine_7.7.4_1_amd64.deb
sudo dpkg -i nomachine_7.7.4_1_amd64.deb
sudo apt-get install -f

banner "installing postman"
sudo snap install postman

banner "Updating vmrc file"
cat <<EOT >> /home/${USER}/.vimrc 
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
rm -rf nomachine_7.7.4_1_amd64.deb
rm -rf minikube-linux-amd64
