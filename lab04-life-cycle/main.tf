variable "from_port" {
    default = 8080
}
variable "to_port" {
    default = 8000
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

output "printport" {
  value = "Hello, security is from ${var.from_port} to ${var.to_port}"
}

resource "aws_security_group" "webserver_sg" {
  name = "sec_open_8080"
  description = "Security group open port ${var.to_port} to access from internet"
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.webserver_sg.id
  from_port         = var.from_port
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
  to_port           = var.to_port
}

resource "aws_instance" "webserver_instance" {
  ami                    = "ami-0ff89c4ce7de192ea"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.webserver_sg.id]
  user_data = file("script.bash")
  tags = {
    Name = "AWS15TerraformDemoEc2"
  }
  lifecycle {
    prevent_destroy = true
  }
}