resource "aws_instance" "example" {
  ami = "ami-09e67e426f25ce0d7"
  instance_type = "t2.micro"
}