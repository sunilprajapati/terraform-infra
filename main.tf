resource "aws_instance" "web" {
  ami           = var.aws_ami
  instance_type = var.istance_type
  key_name      = "AWS9"
  availability_zone = var.az1
  monitoring             = true
  vpc_security_group_ids = [aws_security_group.allow_web.id]
  subnet_id              = aws_subnet.public1.id
  associate_public_ip_address = true

  #network_interface {
  # network_interface_id = aws_network_interface.web-instance-nic.id
  #  device_index         = 0
  #}

user_data = <<-EOF
               #!/bin/bash
                yum install -y httpd php git wget
                cd /var/www/html
                wget https://github.com/rstraining4/content-aws-csa2019/raw/master/lesson_files/07_hybrid_scaling/1_LBandASG/CLBandHealth/cat1.jpg
                mv cat1.jpg cat.jpg
                wget https://github.com/rstraining4/content-aws-csa2019/raw/master/lesson_files/07_hybrid_scaling/1_LBandASG/CLBandHealth/index.php
                mv /var/www/html/htaccess /var/www/html/.htaccess
                mkdir /var/www/html/cat
                cp /var/www/html/cat.jpg /var/www/html/cat
                cp /var/www/html/index.php /var/www/html/cat
                cp /var/www/html/.htaccess /var/www/html/cat
                sudo systemctl start httpd
                sudo systemctl enable httpd
                sudo usermod -a -G apache ec2-user
                sudo chown -R ec2-user:apache /var/www
                sudo chmod 2775 /var/www && find /var/www -type d -exec sudo chmod 2775 {} \;
                find /var/www -type f -exec sudo chmod 0664 {} \;
                EOF
  tags = {
    Name = "web-instance"
  }
  }
  output "instance_public_ip" {
  value = aws_instance.web.public_ip
}
  output "instance_private_ip" {
  value = aws_instance.web.private_ip
}