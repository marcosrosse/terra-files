provider "aws" {
  region = "us-east-1"
  shared_credentials_file = "~/secret"
  profile = "laboratoriodevops"
}

resource "aws_key_pair" "key_ssh" {
  key_name = "my-key"
  public_key = file("~/.ssh/id_rsa.pub") 
}

resource "aws_security_group" "allow_ssh" {
  name = "allow_ssh"
  description = "Grupo criado pelo Terraform para habilitar ssh"
  ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
      from_port = 0 
      to_port = 0
      protocol = -1
      cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "jenkins" {
  name = "jenkins"
  description = "Grupo pelo criado Terraform para habilitar porta 8080"
  ingress {
      from_port = 8080
      to_port = 8080
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
      from_port = 0 
      to_port = 0
      protocol = -1
      cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "jenkins" {
  ami = "ami-07ebfd5b3428b6f4d"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.key_ssh.key_name}"
  security_groups = ["${aws_security_group.allow_ssh.name}", "${aws_security_group.jenkins.name}" ]
  tags = {
    Name = "Jenkins"
  }
}

resource "aws_instance" "node-01" {
  ami = "ami-07ebfd5b3428b6f4d"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.key_ssh.key_name}"
  security_groups = ["${aws_security_group.allow_ssh.name}"]
  tags = {
    Name = "node-01"
  }
}

resource "aws_instance" "node-02" {
  ami = "ami-07ebfd5b3428b6f4d"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.key_ssh.key_name}"
  security_groups = ["${aws_security_group.allow_ssh.name}"]
  tags = {
    Name = "node-02"
  }
}

output "jenkins_public_dns" {
  value = "${aws_instance.jenkins.public_dns}"
}

output "lab01_public_dns" {
   value = "${aws_instance.lab01.public_dns}"
}

output "lab02_public_dns" {
  value = "${aws_instance.lab02.public_dns}"
}