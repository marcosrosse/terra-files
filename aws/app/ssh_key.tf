resource "aws_key_pair" "key_ssh" {
    key_name = "my-key"
    public_key = file("~/.ssh/id_rsa.pub") 
}