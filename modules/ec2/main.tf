resource "aws_instance" "web" {

  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.private_subnet_id

  vpc_security_group_ids = [var.ec2_security_group]

  key_name = var.key_name

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install httpd -y
              systemctl start httpd
              systemctl enable httpd
              echo "Hello from Terraform EC2 in ${terraform.workspace}" > /var/www/html/index.html
              EOF

  tags = {
    Name = "tf-${terraform.workspace}-ec2"
  }
}
