resource "aws_lb" "ext" {
  name               = "${var.env.project_name}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.public_security_groups
  subnets            = var.public_subnets

  enable_deletion_protection = false
}

resource "aws_alb_target_group" "alb-target-group" {
  name        = "${var.env.project_name}-tg-8080"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
   healthy_threshold   = "3"
   interval            = "15"
   protocol            = "HTTP"
   matcher             = "200"
   timeout             = "5"
   path                = "/"
   unhealthy_threshold = "5"
  }
}

resource "aws_alb_listener" "exthttp" {
  load_balancer_arn = aws_lb.ext.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
   type = "redirect"

   redirect {
     port        = 443
     protocol    = "HTTPS"
     status_code = "HTTP_301"
   }
  }
}

resource "aws_alb_listener" "exthttps" {
  load_balancer_arn = aws_lb.ext.arn
  port              = 443
  protocol          = "HTTPS"

  ssl_policy        = "ELBSecurityPolicy-FS-1-2-2019-08"
  certificate_arn   = var.certificate_arn

  default_action {
    target_group_arn = aws_alb_target_group.alb-target-group.arn
    type             = "forward"
  }
}
