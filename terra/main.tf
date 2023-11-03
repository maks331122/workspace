provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "nginx" {
  count		= var.instance_count
  ami		= "ami-0d118c6e63bcb554e"
  instance_type	= "t2.micro"
  key_name      = "maskhavKey"
  tags = {
    Name = "nginx-${count.index}"
  }
  vpc_security_group_ids = [aws_security_group.nginx.id]
}
