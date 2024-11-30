resource "tls_private_key" "pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "aws_key_pair" "generated_key" {
  key_name   = var.keyname
  public_key = tls_private_key.pk.public_key_openssh
}

resource "aws_instance" "web" {
  ami           = "ami-0ff89c4ce7de192ea"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.generated_key.key_name
  tags = {
    Name = "AWS15_Terraform_EC2_HelloWorld"
  }
}
locals {
  instance_ip = aws_instance.web.public_ip
}
output "ssh_command" {
  value = "ssh -i '${var.keyname}.pem' ec2-user@${local.instance_ip}"
}

resource "local_file" "private_key" {
    content  = tls_private_key.pk.private_key_pem
    filename = "private_key.pem"
}
