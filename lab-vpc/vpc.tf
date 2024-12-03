data "aws_vpc" "vpc_selected" {
  id = var.vpc_id
}

data "aws_subnet" "public_subnet" {
  id = var.subnet_id
}