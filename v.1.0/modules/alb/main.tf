resource "aws_lb_target_group" "main" {
  name     = replace(local.name, "rtype", "tg")
  port     = var.app_port
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  health_check {
    path = "/"
    port = var.app_port
  }
  tags = {
    Name = replace(local.name, "rtype", "tg")
  }
}

resource "aws_lb" "main" {
  name               = replace(local.name, "rtype", "alb")
  internal           = false //means public 
  load_balancer_type = "application"
  security_groups    = [aws_security_group.main.id]
  subnets            = var.subnets
  tags = {
    Name = replace(local.name, "rtype", "alb")
  }
}
resource "aws_lb_listener" "main" {
  load_balancer_arn = aws_lb.main.arn
  port              = var.app_port
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }
}
resource "aws_autoscaling_attachment" "asg_attachment" {
  autoscaling_group_name = var.asg_name
  lb_target_group_arn    = aws_lb_target_group.main.arn
}