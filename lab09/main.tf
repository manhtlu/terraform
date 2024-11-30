resource "aws_instance" "webserver_instance" {
  ami                    = "ami-0ff89c4ce7de192ea"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.webserver_sg.id]
  tags = {
    Name = "AWS15TerraformDemoEc2"
  }
}