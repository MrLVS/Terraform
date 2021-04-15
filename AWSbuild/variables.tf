variable "region" {}
variable "ami" {}
output "instance_dns_name" {
  value = aws_instance.web.public_dns
}

