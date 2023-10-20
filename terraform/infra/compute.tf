# locals {
#   web_app_tag = "Web-App"
# }

# data "aws_ami" "latest_ubuntu" {
#    most_recent = true
#    filter {
#      name   = "name"
#      values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
#    }

#    filter {
#      name   = "virtualization-type"
#      values = ["hvm"]
#    }

#    owners = [var.canonical-owner] # Canonical
# }


# resource "aws_instance" "EC2_Webserver" {
#   ami = data.aws_ami.latest_ubuntu.id
#   instance_type = var.instance_type
#   subnet_id = aws_subnet.public-webserver-subnet.id
#   vpc_security_group_ids = [aws_security_group.sg-webserver.id]
#   key_name = var.ec2_key_name

#   tags = {
#     Name = var.instance-name
#     ExtraTag = local.web_app_tag
#   }
# }
