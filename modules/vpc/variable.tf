variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_lb_cidr_block_1" {
  description = "CIDR block for public load balancer subnet"
  type        = string
}
variable "public_lb_cidr_block_2" {
  description = "CIDR block for public load balancer subnet"
  type        = string
}
variable "public_lb_az_1" {
  description = "Availability zone for public load balancer subnet"
  type        = string
}
variable "public_lb_az_2" {
  description = "Availability zone for public load balancer subnet"
  type        = string
}
variable "private_ec2_cidr_block" {
  description = "CIDR block for private EC2 subnet"
  type        = string
}

variable "private_ec2_az" {
  description = "Availability zone for EC2 subnet"
  type        = string
}

variable "private_db_cidr_block" {
  description = "CIDR block for private database subnet"
  type        = string
}

variable "private_db_az" {
  description = "Availability zone for database subnet"
  type        = string
}
