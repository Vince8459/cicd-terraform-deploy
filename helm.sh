#!/bin/bash
apt install openjdk-11-jdk -y

#helm install setup
cd /tmp/
wget https://get.helm.sh/helm-v3.12.1-linux-amd64.tar.gz
tar xzvf helm-v3.12.1-linux-amd64.tar.gz
cd linux-amd64/
sudo mv helm /usr/local/bin/helm

#kops slave setup
sudo mkdir /opt/jenkins-slave
sudo chown ubuntu.ubuntu /opt/jenkins-slave -R
