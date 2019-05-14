FROM centos
RUN yum install epel-release -y
RUN yum install java-1.8.0-openjdk.x86_64 wget -y
RUN cp /etc/profile /etc/profile_backup && echo 'export JAVA_HOME=/usr/lib/jvm/jre-1.8.0-openjdk' | tee -a /etc/profile && echo 'export JRE_HOME=/usr/lib/jvm/jre' | tee -a /etc/profile && source /etc/profile
CMD wget http://34.244.63.46:8081/repository/devops-java-test/org/jar/1.0/devops-day-1.0.jar ; java -jar devops-day-1.0.jar
