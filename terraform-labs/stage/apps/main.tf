module "webservers" {
  source        = "../../modules/webservers"
  instance_type = "t2.micro"
}

resource "aws_security_group_rule" "test" {
  type              = "ingress"
  security_group_id = module.webservers.my_module_sg_id
  from_port         = "100"
  to_port           = "100"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}