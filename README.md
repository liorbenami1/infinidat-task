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
terraform installed & aws cli configured

# Instruction:
1. download the zip file: infinidat-task-lior-ben-ami.zip and unzip it
2. cd to infinidat-task-lior-ben-ami
# OR
1. clone https://github.com/liorbenami1/infinidat-task.git and cd to new cloned folder: infinidat-task
2. copy a tmp-key-pair.pem file to the new folder or change main.tf to your *.pem file


# Usage description
1. cd to the cloned folder or to the new folder (accourding to previos section)
2. run: terraform init
3. run: terraform apply
4. approve: yes
5. Terraform will output the \<public IP\> when finished
6. You can login the teh Ec2 instance with: ssh ubuntu@\<public IP\> -i tmp-key-pair.pem
7. The script will clone the repo under: /var/local/src/instance-bootstrap
8. a /tmp/user_data_boot.log will be created
9. It will take about 5-7 miniutes until the Ec2 instance will create and the user_data.sh finish to run
   
# Access you app:
http://\<public IP\>/hi
