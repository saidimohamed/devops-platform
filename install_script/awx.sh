#!/bin/bash

sudo yum update -y

sudo yum install epel-release -y
sudo yum install git  gcc-c++ make gcc  centos-release-scl  ansible python-pip rh-python36 -y

curl -sL https://rpm.nodesource.com/setup_12.x | sudo -E bash -

sudo yum install nodejs -y

#pip install docker

sudo yum remove docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-engine -y

sudo yum install -y yum-utils device-mapper-persistent-data lvm2

sudo yum-config-manager  --add-repo  https://download.docker.com/linux/centos/docker-ce.repo -y

sudo yum install docker-ce docker-ce-cli containerd.io -y

sudo usermod -aG docker $(whoami)

sudo systemctl enable docker

sudo service docker start



source /opt/rh/rh-python36/enable
pip3 install docker-compose ansible
pip3 install docker


sudo docker-compose version

git clone https://github.com/ansible/awx.git
cd awx/installer
ansible-playbook -i inventory install.yml
