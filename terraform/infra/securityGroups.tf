resource "aws_security_group" "sg-webserver" {
  name = "webserver-sg"
  vpc_id = aws_vpc.webserver-vpc.id
  
}

resource "aws_security_group_rule" "allow_http_traffic" {
  type = "ingress"
  description = "Allow http traffic"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = [aws_vpc.webserver-vpc.cidr_block]
  security_group_id = aws_security_group.sg-webserver.id
}

resource "aws_security_group_rule" "allow_traffic_for_http" {
  type = "egress"
  description = "Allow http traffic"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg-webserver.id
}

resource "aws_security_group_rule" "allow_ssh" {
   type = "ingress"
   from_port = 22
   to_port = 22
   protocol = "tcp"

   cidr_blocks = [var.my_ip]
   security_group_id = aws_security_group.sg-webserver.id
}