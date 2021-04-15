data "aws_ami" "am_linux" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = [var.ami]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

}
