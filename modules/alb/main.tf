resource "aws_lb" "alb" {

  name               = "tf-${terraform.workspace}-alb"
  internal           = false
  load_balancer_type = "application"

  security_groups = [var.lb_security_group]

  subnets = var.public_subnet_ids

  tags = {
    Name = "tf-${terraform.workspace}-alb"
  }
}


resource "aws_lb_target_group" "tg" {

  name     = "tf-${terraform.workspace}-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }

  tags = {
    Name = "tf-${terraform.workspace}-tg"
  }
}


resource "aws_lb_listener" "listener" {

  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {

    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn

  }
}


resource "aws_lb_target_group_attachment" "ec2_attach" {

  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = var.ec2_instance_id
  port             = 80

}
