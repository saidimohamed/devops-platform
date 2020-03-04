#!/bin/bash

docker run -d --name sonarqube -p 9000:9000 sonarqube:7.5-community

docker volume create --name nexus-data
docker run -d -p 8081:8081 --name nexus -v nexus-data:/nexus-data sonatype/nexus3
