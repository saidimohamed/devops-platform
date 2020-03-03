#!/bin/bash
yum install epel-release -y
yum update -y
yum install git  gcc-c++ make gcc  centos-release-scl  ansible python-pip rh-python36 -y

curl -sL https://rpm.nodesource.com/setup_12.x | sudo -E bash -

yum install nodejs -y

#pip install docker

yum remove docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-engine -y

yum install -y yum-utils device-mapper-persistent-data lvm2

yum-config-manager  --add-repo  https://download.docker.com/linux/centos/docker-ce.repo -y

yum install docker-ce docker-ce-cli containerd.io -y

usermod -aG docker $(whoami)

systemctl enable docker

service docker start



source /opt/rh/rh-python36/enable
pip3 install docker-compose ansible docker

docker-compose version

git clone https://github.com/ansible/awx.git
cd awx/installer
ansible-playbook -i inventory install.yml
