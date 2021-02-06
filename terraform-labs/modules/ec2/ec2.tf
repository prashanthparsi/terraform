resource "aws_instance" "hellow-world" {
  ami = "ami-0a313d6098716f372"
  instance_type = var.instance_type
  key_name = "terraform"
  tags = {
    Name = "Hello World"
  }
}