output "vpc_id" {
  value = aws_vpc.this.id
}

output "public_lb_subnet_id_1" {
  value = aws_subnet.public_lb_subnet_1.id
}

output "public_lb_subnet_id_2" {
  value = aws_subnet.public_lb_subnet_2.id
}

output "private_ec2_subnet_id" {
  value = aws_subnet.private_ec2_subnet.id
}

output "private_db_subnet_id" {
  value = aws_subnet.private_db_subnet.id
}

output "lb_security_group" {
  value = aws_security_group.lb_sg.id
}

output "ec2_security_group" {
  value = aws_security_group.ec2_sg.id
}

output "rds_security_group" {
  value = aws_security_group.db_sg.id
}

output "db_subnet_group" {
  value = aws_db_subnet_group.db_subnet_group.name
}
