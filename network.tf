resource "aws_vpc" "MyVPC" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "MyVPC"
  }
}

resource "aws_subnet" "public1" {
  vpc_id     = aws_vpc.MyVPC.id
  cidr_block = "10.0.1.0/24"
  availibility_zone = var.az1

  tags = {
    Name = "Public"
  }
}

resource "aws_subnet" "private1" {
  vpc_id     = aws_vpc.MyVPC.id
  cidr_block = "10.0.2.0/24"
  availibility_zone = var.az2

  tags = {
    Name = "Private"
  }
}

#Internet gateway
resource "aws_internet_gateway" "MyIGW" {
  vpc_id = aws_vpc.MyVPC.id

  tags = {
    Name = "MyIGW"
  }
}

#route tables

resource "aws_route_table" "public-route" {
  vpc_id = aws_vpc.MyVPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.MyIGW.id
  }

  tags = {
    Name = "public-route"
  }
}

#subnet association

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.public-route.id
}
resource "aws_route_table_association" "b" {
  gateway_id     = aws_internet_gateway.public1.id
  route_table_id = aws_route_table.public-route.id
}

#security group


resource "aws_security_group" "allow_web" {
  name        = "allow_web"
  description = "Allow web inbound traffic"
  vpc_id      = aws_vpc.MyVPC.id

  ingress {
    description      = "HTTPS from vpc"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }
  ingress {
    description      = "HTTP from vpc"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }
  ingress {
    description      = "ssh from vpc"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

  tags = {
    Name = "allow_web"
  }
}

#Private IP Address

resource "aws_network_interface" "nic" {
  subnet_id       = aws_subnet.public1.id
  private_ips     = ["10.0.0.50"]
  security_groups = [aws_security_group.allow_web.id]
}

#Public Elastic IP Address
resource "aws_eip" "one" {
  vpc                       = true
  network_interface         = aws_network_interface.nic.id
  associate_with_private_ip = "10.0.0.50"
  depends_on = [aws_internet_gateway.MyIGW]
}