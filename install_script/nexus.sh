#!/bin/bash



#docker volume create --name nexus-data
mkdir /usr/nexus-data
chmod 200 R /usr/nexus-data
docker run -d -p 8081:8081 --name nexus -v /usr/nexus-data:/nexus-data sonatype/nexus3
