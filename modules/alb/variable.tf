variable "vpc_id" {
  type = string
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "lb_security_group" {
  type = string
}

variable "ec2_instance_id" {
  type = string
}
