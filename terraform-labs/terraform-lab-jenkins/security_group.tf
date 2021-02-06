resource "aws_security_group" "webserver_sg" {
  ingress {
    #the below are the github webhook ips https://api.github.com/meta
    cidr_blocks = [var.my_system_cidr, "192.30.252.0/22", "185.199.108.0/22", "140.82.112.0/20"] 
    description = "Terra Form TCP Security Group"
    from_port   = var.http_port
    protocol    = "tcp"
    to_port     = var.http_port
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
