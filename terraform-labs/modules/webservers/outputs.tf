output "DNS_name_elb" {
  value = [aws_elb.my_first_elb.dns_name]
}

output "my_module_sg_id" {
  value = aws_security_group.webserver_sg.id
}