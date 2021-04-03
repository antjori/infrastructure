provider "aws" {
  region = "eu-west-3"
  shared_credentials_file = "~/.aws/credentials"
  profile = "terraform"
}

resource "aws_instance" "example" {
  ami                     = "ami-00dd995cb6f0a5219"
  instance_type           = "t2.micro"
  vpc_security_group_ids  = [aws_security_group.instance.id]
  key_name  = "Terraform"
  user_data = <<-EOF
              #!/bin/bash
              # Use this for your user data (script without newlines)
              # install httpd (Linux 2 version)
              yum update -y
              yum install -y httpd.x86_64
              systemctl start httpd.service
              systemctl enable httpd.service
              echo "Hello Terraform World from $(hostname -f)" > /var/www/html/index.html
              EOF
  tags = {
    Name = "terraform-example"
  }
}

resource "aws_security_group" "instance" {
  name = "terraform-example-instance"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
