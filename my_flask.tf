terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 2.70"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "us-west-2"
}

resource "aws_instance" "my-flask-app" {
  ami           = "ami-830c94e3"
  instance_type = "t2.micro"

  tags = {
    name = "my-flask-app"
  }

  provisioner "remote-exec" {
    connection {
      type     = "ssh"
      user     = "root"
      private_key = file("D:/devops/my_key.pem")
      host = "${element(aws_instance.my-flask-app.*.public_ip, 0)}"
    }
    inline = [
      "sudo amazon-linux-extras install ansible2 -y",
      "sudo apt install git -y",
      "git clone https://github.com/devops-school/ansible-hello-world-role /tmp/ans_ws",
      "ansible-playbook /tmp/ans_ws/site.yaml"
    ]
  }
}

resource "aws_eip" "ip" {
  vpc      = true
  instance = aws_instance.my-flask-app.id
}


/*
provider "aws" {
  region = "eu-west-1"
  shared_credentials_file = "~/.aws/credentials"
}

resource "aws_instance" "web" {
  ami           = "ami-00ddb0e5626798373"
  instance_type = "t2.micro"
  
  tags = {
    name = "my-flask-app"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo amazon-linux-extras install ansible2 -y",
      "sudo apt install git -y",
      "git clone https://github.com/devops-school/ansible-hello-world-role /tmp/ans_ws",
      "ansible-playbook /tmp/ans_ws/site.yaml"
    ]
  }
}
*/
