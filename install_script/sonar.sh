#!/bin/bash

docker run -d --name sonarqube -p 80:9000 sonarqube:7.5-community
