# UnboxLinux
This repository main intention is to palce all the instruction at one place to 
* Unbox your new linux machine 
* Hasslefree Python setup
* Build best Continution integration pipeline evironments.

## Ubuntu
* [Ubuntu 16.04 (xenial)](./ubuntu/ubuntu_16.md)
* [Ubuntu 20 LTS](./setup.sh)
It waits for password plese input
wget -O - https://raw.githubusercontent.com/vkosuri/UnboxLinux/master/setup.sh | bash

## Issues
```
E: Conflicting values set for option Signed-By regarding source https://apt.kubernetes.io/ kubernetes-xenial: /usr/share/keyrings/kubernetes-archive-keyring.gpg != 
E: The list of sources could not be read.
installing curl
E: Conflicting values set for option Signed-By regarding source https://apt.kubernetes.io/ kubernetes-xenial: /usr/share/keyrings/kubernetes-archive-keyring.gpg != 
E: The list of sources could not be read.
E: Conflicting values set for option Signed-By regarding source https://apt.kubernetes.io/ kubernetes-xenial: /usr/share/keyrings/kubernetes-archive-keyring.gpg != 
E: The list of sources could not be read.
^C
```
Remove the source files
sudo rm -rf /etc/apt/sources.list.d/kubernetes.list.save
sudo rm -rf /etc/apt/sources.list.d/kubernetes.list

## Contributions
You are most welcome to edit or create content useful to others.

Happy Documentation


