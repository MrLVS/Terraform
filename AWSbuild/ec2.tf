provider "aws" {
    region      = var.region
}

resource "aws_instance" "web" {
  subnet_id = aws_subnet.public.id
  ami           = var.ami
  instance_type = "t2.micro"
  vpc_security_group_ids  = [aws_security_group.allow_http_https.id]
	user_data = file("script.sh")

  tags = {
    Name = "web"
  }
}
