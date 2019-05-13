#!/bin/bash

sudo yum -y install epel-release
sudo yum -y update
sudo yum install -y java-1.8.0-openjdk.x86_64 wget


sudo cp /etc/profile /etc/profile_backup
echo 'export JAVA_HOME=/usr/lib/jvm/jre-1.8.0-openjdk' | sudo tee -a /etc/profile
echo 'export JRE_HOME=/usr/lib/jvm/jre' | sudo tee -a /etc/profile
source /etc/profile

sudo rpm -Uvh https://download.postgresql.org/pub/repos/yum/9.6/redhat/rhel-7-x86_64/pgdg-centos96-9.6-3.noarch.rpm
sudo yum -y install postgresql96-server postgresql96-contrib
sudo /usr/pgsql-9.6/bin/postgresql96-setup initdb

sudo systemctl start postgresql-9.6
sudo systemctl enable postgresql-9.6
sudo echo "postgres" | passwd --stdin postgres
su - postgres
createuser sonar
psql -c "ALTER USER sonar WITH ENCRYPTED password 'sonar'"
psql -c "CREATE DATABASE sonar OWNER sonar"
