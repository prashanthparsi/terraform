variable "region" {
  default = "us-east-1"
}

variable "http_port" {
  default = 8080
}

variable "ssh_port" {
  default = 22
}

variable "my_system_cidr" {
  default = "99.89.92.59/32"
}

variable "ami" {
  default = "ami-0a313d6098716f372"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "project" {
  default = "jenkins"
}