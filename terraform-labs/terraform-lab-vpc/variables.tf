variable "region" {
  default = "us-east-1"
}

variable "http_port" {
  default = 80
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

variable "azs" {
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}
