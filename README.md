#TERRAFORM PIPELINE DEPLOYMENT USING JENKINS, DOCKER & KUBERNETES HELM

The script below uses terraform Infrastructure as Code to deploy a Jenkins and Kops servers. 
Kops is used to run kubernetes and it also has helm to deploy the kubernetes files.
Jenkins is used to build the artifact, build docker image, deploy docker image and finally deploy the kubernetes using helm
Kops server is configured as a slave to the Jenkins Server.

#PREREQUISITES
1. Install Terraform in local machine.
2. Configure AWS account in local machine.
3. Generate a public & private key for both the Jenkins and Kops Server.

In the Kops Server:
1. Configure AWS account.
2. Create Kubernetes cluster.
3. Update Kubernetes cluster.
4. Validate Kubernetes cluster.

In the Jenkins Server:
1. Get the Jenkins initial password: sudo cat /var/lib/jenkins/secrets/initialAdminPassword
2. Install plugins: Docker Pipeline, Docker, Pipeline Utility Steps.
3. Global Tool Configuration: Maven & JDK
4. Configure credentials: add Dockerhub credentials.
5. Add slave node: i.e the Kops Server


Terraform creates a Virtual Private Cloud in AWS which has a Jenkins and Kops server. Terraform uses the file provisioner to copy
installation scripts from the local machine to the EC2 instances being created and then executes the scripts using the remote-exec provisioner
to run the scripts in the servers. From the Jenkins server run the Jenkins pipeline from the Source Code Manager which is our Github account to execute
the rest of the project.