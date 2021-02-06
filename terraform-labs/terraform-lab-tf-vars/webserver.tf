#command to run this project
#terraform init -var-file="silicon_valley.tfvars" -backend-config="key=silicon_valley/terraform.tfstate" -reconfigure
#terraform plan -var-file="silicon_valley.tfvars"
#terraform apply -var-file="silicon_valley.tfvars" -auto-approve
#terraform destroy -var-file="silicon_valley.tfvars" -auto-approve
#re initialize
#terraform init -var-file="golden_gate.tfvars" -backend-config="key=golden_gate/terraform.tfstate" -reconfigure
#terraform plan -var-file="golden_gate.tfvars"
#terraform apply -var-file="golden_gate.tfvars" -auto-approve
#terraform destroy -var-file="golden_gate.tfvars" -auto-approve
resource "aws_instance" "hellow-world" {
  ami                    = var.ami
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.webserver_sg.id]
  key_name               = "terraform"
  tags = {
    Name = "Hello World"
  }

  user_data = <<-EOF
    #!/bin/bash
    exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
    /usr/bin/apt-get update
    DEBIAN_FRONTEND=noninteractive /usr/bin/apt-get upgrade -yq
    /usr/bin/apt-get install apache2 -y
    /usr/sbin/ufw allow in "Apache Full"
    /bin/echo "Hello world " >/var/www/html/index.html
    instance_ip=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
    echo $instance_ip >>/var/www/html/index.html
  EOF
}