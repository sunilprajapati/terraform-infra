resource "aws_instance" "web" {
  ami           = ami-0af25d0df86db00c1
  instance_type = "t2.micro"

  tags = {
    Name = "HelloWorld"
  }
}