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

data "template_file" "user-data"{
  template = "${file("${path.module}/install_apache.sh")}"
}

resource "aws_instance" "web" {
  ami           = "ami-560fbb36"
  instance_type = "t2.micro"
  user_data     = data.template_file.user-data.template
  vpc_security_group_ids = ["sg-0a32c0170c2d8df8c"]
  tags ={
    name = "Gabos instance"
  }
}




output "DNS" {
  value = aws_instance.web.public_dns
}