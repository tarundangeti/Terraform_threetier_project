variable "ami_id" {
  description = "AMI ID for EC2"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "private_subnet_id" {
  description = "Private subnet for EC2"
  type        = string
}

variable "ec2_security_group" {
  description = "EC2 security group id"
  type        = string
}

variable "key_name" {
  description = "Key pair name"
  type        = string
}
