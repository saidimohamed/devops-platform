#!/bin/bash



#docker volume create --name nexus-data
mkdir /usr/nexus-data
chmod 777 -R /usr/nexus-data
docker run -d -p 80:8081 --name nexus -v /usr/nexus-data:/nexus-data sonatype/nexus3
