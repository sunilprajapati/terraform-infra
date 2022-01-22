resource "aws_instance" "web" {
  ami           = var.aws_ami
  instance_type = "t2.micro"

  tags = {
    Name = "HelloWorld"
  }
}