resource "aws_security_group" "webserver_sg" {
  ingress {
    cidr_blocks = ["99.89.92.59/32"]
    description = "Terra Form TCP Security Group"
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
  }

  ingress {
    cidr_blocks = ["99.89.92.59/32"]
    description = "Terra Form SSH Security Group"
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }
}
