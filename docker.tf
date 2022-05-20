provider "aws" {
    region     = "ap-south-1"
    access_key = "xxxxx"
    secret_key = "xxxxx"

}
resource "aws_instance" "app_server" { 

    ami = "ami-079b5e5b3971bd10d"
    instance_type = "t2.micro"
}
data "aws_ami" "ec2_ami" {
    most_recent = true
    owners = ["amazon"]

filter {
    name   = "name"
    values = ["Amazon Linux 2 Kernel 5.10 AMI 2.0.20220426.0 x86_64 HVM gp2"]
}
}
variable "ec2_name" {

default = "terraform1_instance"
}


    output "ec2_ip" {
    value = aws_instance.app_server
}
resource "aws_instance" "web" {
  

  provisioner "local-exec" {
    command = "echo The server's IP address is ${self.public.id}"
  }

  provisioner "file" {
  source      = "conf/myapp.conf"
  destination = "/etc/myapp.conf"

  connection {
    type     = "ssh"
    user     = "root"
    password = "${var.root_password}"
    host     = "${var.host}"
  }
}
    
 }
