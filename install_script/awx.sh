#!/bin/bash
yum install -y epel-release
yum update -y
yum install -y yum-utils device-mapper-persistent-data lvm2 ansible git python-devel python-pip vim-enhanced

pip install cryptography
pip install jsonschema
pip install docker-compose~=1.23.0
pip install docker --upgrade

yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

yum install docker-ce -y

systemctl start docker

systemctl enable docker

git clone https://github.com/ansible/awx.git

cd awx/installer/

ansible-playbook -i inventory install.yml
