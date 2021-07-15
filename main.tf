terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "web" {
  ami           = "ami-560fbb36"
  instance_type = "t2.micro"
  user_data     = <<-EOF
                  #!/bin/bash -xe
                  cd /tmp
                  yum update -y
                  yum install -y httpd
                  echo "Hello from the EC2 instance $(hostname -f)." > /var/www/html/index.html
                  systemctl start httpd
                  EOF
}




output "DNS" {
  value = aws_instance.web.public_dns
}