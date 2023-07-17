#!/bin/bash
sudo apt update && sudo apt install awscli -y
#ssh-keygen
#aws configure**

##install&setup kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x ./kubectl
sudo mv kubectl /usr/local/bin/

##installing kubernetes with kops
curl -LO https://github.com/kubernetes/kops/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)/kops-linux-amd64
sudo chmod +x kops-linux-amd64
sudo mv kops-linux-amd64 /usr/local/bin/kops

##copy repo
git clone https://github.com/Vince8459/cicd-helm-deploy.git
cd cicd-helm-deploy/
kubectl create namespace prod

##creating clusters
#kops create cluster --name=kopsvpro.embracing-ai.com \ 
#--state=s3://kops-buck --zones=us-east-1a,us-east-1b \ 
#--node-count=2 --node-size=t3.small --master-size=t3.medium --dns-zone=kopsvpro.embracing-ai.com \ 
#--node-volume-size=8 --master-volume-size=8

#sleep 2;

#kops update cluster --name kopsvpro.embracing-ai.com --state=s3://kops-buck --yes --admin

#wait 10min command**
#sleep 900

#kops validate cluster --name kopsvpro.embracing-ai.com --state=s3://kops-buck

#kops delete cluster --name=kopsvpro.embracing-ai.com --state=s3://kops-buck --yes

