provider "aws" {
  region  = "us-east-1"
  profile = "iamAdminProd"
}

resource "aws_subnet" "web_subnet" {
  vpc_id     = aws_vpc.mainVPC.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "sn-app-az1"
  }
}
resource "aws_vpc" "mainVPC" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "mainVPC"
  }
}
resource "aws_internet_gateway" "mainVPC_gateway" {
  vpc_id = aws_vpc.mainVPC.id
}

resource "aws_route_table" "publicRT" {
  vpc_id = aws_vpc.mainVPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.mainVPC_gateway.id
  }
}
resource "aws_route_table_association" "rta_web_subnet" {

  subnet_id      = aws_subnet.web_subnet.id
  route_table_id = aws_route_table.publicRT.id
}
resource "aws_instance" "web_server" {
  user_data              = file("script.sh")
  subnet_id              = aws_subnet.web_subnet.id
  ami                    = data.aws_ami.am_linux.id
  instance_type          = var.EC2_type
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  tags = {
    Name = var.server_name
  }
}
resource "aws_security_group" "web_sg" {
  vpc_id = aws_vpc.mainVPC.id
  name   = "web_sg"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  #HTTP access
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
