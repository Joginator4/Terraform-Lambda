variable "aws_region" {
  default = "us-east-1"
  type = string
}

variable "web-bucket" {
    default = "WebBucket"
    type = string
}

variable "instance-name" {
  default = "Webserver"
  type = string
}

variable "vpc-cidr-block" {
    default = "10.0.0.0/16"
    type = string
}

variable "public-subnet-cidr-block" {
    default = "10.0.0.0/24"
    type = string
}

variable "canonical-owner" {
    default = "099720109477"
    type = string
}

variable "instance_type" {
  default = "t2.micro"
  type = string
}

variable "my_ip" {
  default = "185.23.12.218/32"
  type = string
}

variable "ec2_key_name" {
  default = "zblakac_aws"
  type = string
}

variable "client-settlements" {
  default = "client-settlements"
  type = string
}

#sensitive = true  , for password to avoid echo on terminal