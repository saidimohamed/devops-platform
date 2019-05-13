#!/bin/bash

sudo yum install epel-release -y

sudo yum update -y

sudo yum install java-1.8.0-openjdk.x86_64 wget -y


sudo cp /etc/profile /etc/profile_backup
echo 'export JAVA_HOME=/usr/lib/jvm/jre-1.8.0-openjdk' | sudo tee -a /etc/profile
echo 'export JRE_HOME=/usr/lib/jvm/jre' | sudo tee -a /etc/profile
source /etc/profile

echo $JAVA_HOME
echo $JRE_HOME

sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
sudo yum install jenkins -y

sudo systemctl start jenkins.service
sudo systemctl enable jenkins.service

sudo mkdir -p /var/lib/jenkins/init.groovy.d/

sudo chown -R jenkins:jenkins /var/lib/jenkins/init.groovy.d/

sudo cd home/centos/devops-platform/install_script
sudo cp basic-security.groovy /var/lib/jenkins/init.groovy.d/
sudo rm -rf /etc/sysconfig/jenkins
sudo cp jenkins_options /etc/sysconfig/jenkins
sudo chown jenkins:jenkins /var/lib/jenkins/init.groovy.d/basic-security.groovy


sudo systemctl restart jenkins.service
