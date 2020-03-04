#!/bin/bash

sudo yum -y install epel-release
sudo yum -y update
sudo yum install -y java-1.8.0-openjdk.x86_64 wget unzip


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

su - -c  "createuser sonar" postgres
su - -c "psql -c \"ALTER USER sonar WITH ENCRYPTED password 'sonar'\"" postgres
su - -c  "psql -c \"CREATE DATABASE sonar OWNER sonar\"" postgres

wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-7.7.zip
unzip sonarqube-7.7.zip -d /opt
mv /opt/sonarqube-7.7 /opt/sonarqube

sed -i -e 's/^#sonar.jdbc.username.*/sonar.jdbc.username="sonar"/g' /opt/sonarqube/conf/sonar.properties
sed -i -e 's/^#sonar.jdbc.password.*/sonar.jdbc.password="sonar"/g' /opt/sonarqube/conf/sonar.properties
sed -i -e 's/^#sonar.jdbc.url=jdbc:postgresql:\/\/localhost\/sonar.*/sonar.jdbc.url=jdbc:postgresql:\/\/localhost\/sonar/g' /opt/sonarqube/conf/sonar.properties

echo '[Unit]
Description=SonarQube service
After=syslog.target network.target
[Service]
Type=forking
ExecStart=/opt/sonarqube/bin/linux-x86-64/sonar.sh start
ExecStop=/opt/sonarqube/bin/linux-x86-64/sonar.sh stop
User=root
Group=root
Restart=always
[Install]
WantedBy=multi-user.target' > /etc/systemd/system/sonar.service

sudo systemctl start sonar
sudo systemctl enable sonar

