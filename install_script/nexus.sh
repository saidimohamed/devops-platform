#!/bin/bash

sudo yum update -y
sudo yum install  java-1.8.0-openjdk.x86_64  wget -y



sudo cp /etc/profile /etc/profile_backup
echo 'export JAVA_HOME=/usr/lib/jvm/jre-1.8.0-openjdk' | sudo tee -a /etc/profile
echo 'export JRE_HOME=/usr/lib/jvm/jre' | sudo tee -a /etc/profile
source /etc/profile

sudo wget http://download.sonatype.com/nexus/3/latest-unix.tar.gz
sudo tar xvf latest-unix.tar.gz -C /opt
sudo mv  /opt/nexus-3.16.1-02/ /opt/nexus

sudo adduser nexus
sudo chown -R nexus:nexus /opt/nexus

sudo sed -i -e 's/^#run_as_user.*/run_as_user="nexus"/g' /opt/nexus/bin/nexus.rc

sudo ln -s /opt/nexus/bin/nexus /etc/init.d/nexus
sudo systemctl enable nexus

sudo systemctl start nexus
