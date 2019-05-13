#!/bin/bash

sudo yum update -y
sudo yum install wget -y


sudo wget http://download.sonatype.com/nexus/3/latest-unix.tar.gz
sudo tar xvf latest-unix.tar.gz -C /opt
sudo ln -s /opt/nexus-3.3.1-01/ /opt/nexus

sudo adduser nexus
sudo chown -R nexus:nexus /opt/nexus
sed -i -e 's/^#run_as_user/run_as_user="nexus"/g' /opt/nexus/bin/nexus.rc

sudo ln -s /opt/nexus/bin/nexus /etc/init.d/nexus
sudo systemctl enable nexus

sudo systemctl start nexus
