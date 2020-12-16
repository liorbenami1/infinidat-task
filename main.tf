provider "aws" {
	region = "us-east-1"
}

#resource "aws_key_pair" "terraform-demo" {
#  key_name   = "terraform-demo"
#  public_key = "${file("terraform-demo.pub")}"
#}

resource "aws_instance" "my-instance" {
	ami = "ami-04169656fea786776"
	instance_type = "t2.nano"
	#key_name = "${aws_key_pair.terraform-demo.key_name}"
	key_name = "my-key-pair.pem"
	user_data = "${file("user_data.sh")}"
	tags = {
		Name = "Terraform"	
		Batch = "5AM"
	}
}

resource "aws_eip" "ip" {
  vpc      = true
  instance = aws_instance.my-instance.id
}
