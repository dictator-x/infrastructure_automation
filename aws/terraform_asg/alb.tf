resource "aws_lb" "application_lb" {
  name = "application-lb"
  internal = false
  load_balancer_type = "application"
  subnets = data.aws_subnet_ids.public.ids
  security_groups = [aws_security_group.allow_ssh_http_tls.id]
  enable_deletion_protection = false
}

resource "aws_lb_listener" "http_lb_listener" {
  load_balancer_arn = aws_lb.application_lb.arn
  port = "80"
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.lb_http_target_group.arn
  }
}

resource "aws_lb_target_group" "lb_http_target_group" {
  name = "lb-http-target-group"
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.vpc.id
  target_type = "instance"

  health_check {
    enabled = true
    interval = 30
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    path = "/"
    port = "80"
  }
}

# HTTPS target group
# resource "aws_lb_target_group" "lb_https_target_group" {
#   name = "lb-https-target-group"
#   port = 443
#   protocol = "HTTPS"
#   vpc_id = aws_vpc.vpc.id
#   target_type = "instance"
# }
