resource "aws_vpc" "webserver-vpc" {
   cidr_block = var.vpc-cidr-block
   instance_tenancy = "default"

}

resource "aws_internet_gateway" "vpc-webserver-igw" {
   vpc_id = aws_vpc.webserver-vpc.id
   tags = {
     Name = "Webserver-VPC-IGW"
   }
}

resource "aws_route_table" "vpc-webserver-route-table" {
  vpc_id = aws_vpc.webserver-vpc.id
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc-webserver-igw.id

  }

}

resource "aws_main_route_table_association" "vpc-webserver-rt" {
  vpc_id = aws_vpc.webserver-vpc.id
  route_table_id = aws_route_table.vpc-webserver-route-table.id
}

resource "aws_subnet" "public-webserver-subnet" {
  vpc_id = aws_vpc.webserver-vpc.id
  cidr_block = var.public-subnet-cidr-block

  map_public_ip_on_launch = true
}
