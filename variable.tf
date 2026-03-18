variable "vpc_cidr_block" {
  type = string
}

variable "public_lb_cidr_block_1" {
  type = string
}
variable "public_lb_cidr_block_2" {
  type = string
}
variable "public_lb_az_1" {
  type = string
}
variable "public_lb_az_2" {
  type = string
}

variable "private_ec2_cidr_block" {
  type = string
}

variable "private_ec2_az" {
  type = string
}

variable "private_db_cidr_block" {
  type = string
}

variable "private_db_az" {
  type = string
}
variable "ami_id" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "key_name" {
  type = string
}
