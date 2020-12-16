# Packaging a Flask App
# Problem description: 
1. Create single page flask app with some info about yourself
2. Create Ansible role which deploys a Docker container running your app
3. Create a Terraform role to provision instance in aws
4. Integrate both (executing terraform should trigger the ansible on the provisioned instance)

# Sulotion:
1. Terraform will provision an AWS Ec2 instance with security group enable SSH, HTTP, and port 80
2. when the Ec2 instance will create a bash script will execute (invoke from terraform user_data)
3. This script will install git, ansible and will clone this repo and execute the playbook to invoke the ansible role
4. The ansible role (named: my-flask) will:
        create a docker image from out flask app
        run container from this image
# pre-requisite:
1. terraform installed & aws cli configured
2. clone this repo or copy all *.tf files and user_data.sh to a fresh folder
3. copy a tmp-key-pair.pem file to the new folder or change main.tf to your *.pem file

# Usage description
1. cd to the cloned folder or to the new folder (accourding to previos section)
2. run: terraform init
3. run: terraform apply
4. approve: yes
5. It will take about 5-7 miniutes until the Ec2 instance will create and the user_data.sh finish to run
6. Terraform will output the \<public IP\> when finished
   
# Access you app:
http://\<public IP\>/hi
