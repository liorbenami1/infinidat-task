provider "aws" {
	region = "us-east-1"
}

resource "aws_security_group" "ubuntu" {
  name        = "ubuntu-security-group"
  description = "Allow HTTP, HTTPS and SSH traffic"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terraform"
  }
}

resource "aws_instance" "ubuntu" {
	ami = "ami-04169656fea786776"
	instance_type = "t2.micro"
	key_name = "myKeyPair"
	user_data = file("user_data.sh")
	tags = {
		Name = "ubuntu"	
	}

        vpc_security_group_ids = [
          	aws_security_group.ubuntu.id
        ]

  	connection {
    		type        = "ssh"
    		user        = "ubuntu"
    		private_key = file("tmp-key-pair")
  		#  private_key = file("key")
    		host        = self.public_ip
  	}
}


resource "aws_eip" "ip" {
  vpc      = true
  instance = aws_instance.ubuntu.id
}
