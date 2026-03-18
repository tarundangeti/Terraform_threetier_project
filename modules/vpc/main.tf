resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr_block
  tags = {
   Name = "tf-${terraform.workspace}-vpc"
  }
}
resource "aws_subnet" "public_lb_subnet_1" {
  vpc_id = aws_vpc.this.id
  cidr_block = var.public_lb_cidr_block_1
  availability_zone = var.public_lb_az_1
  map_public_ip_on_launch = true
  tags = {
   Name = "tf-${terraform.workspace}-public-lb-subnet_1"
  }
}
resource "aws_subnet" "public_lb_subnet_2" {
  vpc_id = aws_vpc.this.id
  cidr_block = var.public_lb_cidr_block_2
  availability_zone = var.public_lb_az_2
  map_public_ip_on_launch = true
  tags = {
   Name = "tf-${terraform.workspace}-public-lb-subnet_2"
  }
}
resource "aws_subnet" "private_ec2_subnet" {
  vpc_id = aws_vpc.this.id
  availability_zone = var.private_ec2_az
  cidr_block = var.private_ec2_cidr_block
  tags = {
   Name = "tf-${terraform.workspace}-private-ec2-subnet"
  }
}
resource "aws_subnet" "private_db_subnet" {
  vpc_id = aws_vpc.this.id
  cidr_block = var.private_db_cidr_block
  availability_zone = var.private_db_az
  tags = {
   Name = "tf-${terraform.workspace}-private-db-subnet"
  }
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.this.id
  tags = {
   Name = "tf-${terraform.workspace}-igw"
  }
}
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.this.id
  route {
   cidr_block = "0.0.0.0/0"
   gateway_id = aws_internet_gateway.igw.id
  }
}
resource "aws_route_table_association" "rta1" {
  route_table_id = aws_route_table.rt.id
  subnet_id = aws_subnet.public_lb_subnet_1.id
}
resource "aws_route_table_association" "rta2" {
  route_table_id = aws_route_table.rt.id
  subnet_id = aws_subnet.public_lb_subnet_2.id
}
resource "aws_security_group" "lb_sg" {
  vpc_id = aws_vpc.this.id
  ingress {
  description = "this is to allow traffic to load balancer"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
  description = "this is to block the traffic to outside"
  from_port = 0
  to_port = 0
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
   Name = "tf-${terraform.workspace}-lb-sg"
  }
}
# ---------
# ec2-security-group
# ---------
resource "aws_security_group" "ec2_sg" {
  vpc_id = aws_vpc.this.id
  ingress {
    description = "this is to allow trafic from lb security group"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    security_groups = [aws_security_group.lb_sg.id]
  }
  egress {
    description = "this is to cut out the out bound"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
   Name = "tf-${terraform.workspace}-ec2-sg"
  }
}
# ---------
# db-security-group
# ---------
resource "aws_security_group" "db_sg" {
  vpc_id = aws_vpc.this.id
  ingress {
    description = "this is to allow trafic from ec2 security group to db"
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    security_groups = [aws_security_group.ec2_sg.id]
  }
  egress {
    description = "this is to cut out the out bound"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
   Name = "tf-${terraform.workspace}-db-sg"
  }
}
resource "aws_db_subnet_group" "db_subnet_group" {
  name = "tf-db-subnet-group"
  subnet_ids = [aws_subnet.private_ec2_subnet.id, aws_subnet.private_db_subnet.id]
  tags = {
   Name = "tf-${terraform.workspace}-db-subnet-group" 
  }
}
