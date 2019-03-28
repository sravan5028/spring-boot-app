#!/bin/bash
sudo yum update -y
sudo yum remove *java* -y
sudo yum install wget java-1.8.0-openjdk java-1.8.0-openjdk-devel -y
wget http://172.31.86.70:8081/nexus/content/repositories/maven_release/com/javainuse/spring-boot-aop/0.0.1/spring-boot-aop-0.0.1.jar
nohup java -jar spring-boot-aop-0.0.1.jar &
