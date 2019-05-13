#!/bin/bash
docker pull sonarqube
docker pull sonatype/nexus3

docker run -d --name sonarqube -p 9000:9000 sonarqube

mkdir /opt/nexus-data && chown -R 200 /opt/nexus-data
docker run -d -p 8081:8081 --name nexus -v /opt/nexus-data:/nexus-data sonatype/nexus3

#docker volume create --name nexus-data
#docker run -d -p 8081:8081 --name nexus -v nexus-data:/nexus-data sonatype/nexus3
