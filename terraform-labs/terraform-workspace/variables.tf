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
  type = map(any)

  default = {
    default = "t2.nano"
    stage   = "t2.micro"
    prod    = "t2.large"

  }
}