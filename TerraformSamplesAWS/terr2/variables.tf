variable "region" {
  default = "us-east-1"
}
variable "server_name" {
  default = "server_name"
}
variable "ssh_key_name" {
  default = "ssh_key_name"
}
variable "ami" {
  default = "amzn2-ami-hvm-*-x86_64-gp2"
}
variable "EC2_type" {
  default = "t2.micro"
}
variable "pub_ip" {
  default = "pub_ip_address"
}
