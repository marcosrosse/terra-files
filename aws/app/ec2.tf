data "aws_ami" "ubuntu" {
  most_recent = true
  
  filter {
    name = "name"
    values = [""]
}
  owners = [""]
}

resource "aws_instance" "web" {
  count         =  var.hosts
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name = "my-key"
  #key_name = "${aws_key_pair.key_ssh.key_name}"
  security_groups = ["${aws_security_group.allow_ssh.name}"]

  tags = {
    Name = "lab"
  }
}
