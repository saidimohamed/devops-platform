FROM centos
RUN sudo yum install epel-release -y
RUN sudo yum install java-1.8.0-openjdk.x86_64 wget -y
RUN sudo cp /etc/profile /etc/profile_backup && echo 'export JAVA_HOME=/usr/lib/jvm/jre-1.8.0-openjdk' | sudo tee -a /etc/profile && echo 'export JRE_HOME=/usr/lib/jvm/jre' | sudo tee -a /etc/profile && source /etc/profile
RUN wget http://34.244.63.46:8081/repository/devops-java-test/org/jar/1.0/devops-day-1.0.jar
CMD ["java","-jar devops-day-1.0.jar"] 
