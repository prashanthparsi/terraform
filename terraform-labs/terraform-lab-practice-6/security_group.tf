resource "aws_security_group" "webserver_sg" {
  ingress {
    cidr_blocks = [var.my_system_cidr]
    description = "Terra Form TCP Security Group"
    from_port   = var.http_port
    protocol    = "tcp"
    to_port     = var.http_port
  }

  ingress {
    from_port       = var.http_port
    protocol        = "tcp"
    to_port         = var.http_port
    security_groups = ["sg-0e17c0fc1e7b92749"]
  }

  ingress {
    cidr_blocks = [var.my_system_cidr]
    description = "Terra Form SSH Security Group"
    from_port   = var.ssh_port
    protocol    = "tcp"
    to_port     = var.ssh_port
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }
}
