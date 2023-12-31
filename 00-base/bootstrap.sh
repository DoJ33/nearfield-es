#!/bin/bash

# Update hosts file
# echo "[TASK 1] Update /etc/hosts file"
# cat >>/etc/hosts<<EOF
# 172.16.16.101 node1
# 172.16.16.102 node2
# 172.16.16.103 node3
# 172.16.16.104 node4
# EOF

# Enable ssh password authentication
echo "[TASK 2] Enable ssh password authentication"
sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Enable root ssh login
echo "[TASK 3] Enable ssh root login"
sed -i 's/.*PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config

systemctl reload sshd

# Set Root password
echo "[TASK 4] Set root password"
echo root:kubeadmin | chpasswd

# Install snap for debian
# sudo apt update -y
# sudo apt upgrade -y
# sudo apt install snapd -y
# sudo systemctl start snapd
# sudo systemctl enable snapd
# sudo snap install core

## Install microk8s
echo "[TASK 5] Install Microk8s and set"
sudo snap install microk8s --classic
sudo usermod -a -G microk8s $USER
sudo chown -f -R $USER ~/.kube
# newgrp microk8s

alias kubectl='microk8s kubectl'
alias helm='microk8s helm'
alias ctr='microk8s ctr'
sudo reboot
