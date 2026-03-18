# VPC

vpc_cidr_block = "192.168.0.0/16" 
# Public Subnet for Load Balancer
public_lb_cidr_block_1 = "192.168.4.0/24"
public_lb_cidr_block_2 = "192.168.5.0/24" 
public_lb_az_1         = "ap-south-1a"
public_lb_az_2         = "ap-south-1b"
# Private Subnet for EC2
private_ec2_cidr_block = "192.168.6.0/24" 
private_ec2_az         = "ap-south-1b"
# Private Subnet for Database
private_db_cidr_block = "192.168.7.0/24" 
private_db_az         = "ap-south-1c"
# instance variables
ami_id = "ami-06c643a49c853da56"
instance_type = "t2.micro"
key_name = "tarunpem5/02/2025"
