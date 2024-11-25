variable "from_port" {
  type = number
  default = 8080
}
variable "to_port" {
  type = number
  default = 8080
}
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.25"
    }
  }
  required_version = ">= 1.2.5"
}
provider "aws" {
  region = "ap-southeast-1"
}
resource "aws_instance" "app_server" {
  ami                    = "ami-0ff89c4ce7de192ea"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.arn]
  user_data = file("script.bash")
  tags = {
    Name = "AWS15TerraformDemoEc2"
  }
}

resource "aws_security_group" "instance" {
  name = "sec_open_8080"
  ingress {
    from_port   = var.from_port
    to_port     = var.to_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
