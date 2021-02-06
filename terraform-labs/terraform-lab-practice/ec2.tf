resource "aws_instance" "hellow-world" {
  ami = "ami-0a313d6098716f372"
  instance_type = "t2.micro"
  key_name = "terraform" #this is the key created in aws key pairs
  tags = {
    Name = "Hello World"
  }
}