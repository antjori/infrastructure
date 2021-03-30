provider "aws" {
  region = "eu-west-3"
  shared_credentials_file = "~/.aws/credentials"
  profile = "terraform"
}

resource "aws_instance" "example" {
  ami           = "ami-0d6aecf0f0425f42a"
  instance_type = "t2.micro"
  tags = {
    Name = "terraform-example"
  }
}
