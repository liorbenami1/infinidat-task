provider "aws" {
  region = "eu-west-2"
  shared_credentials_file = "~/.aws/credentials"
}

resource "aws_instance" "web" {
  ami           = "ami-0c09927662c939f41"
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

