resource "aws_elb" "classic_elb" {
  name = "classic-elb"
  internal = false
  subnets = data.aws_subnet_ids.public.ids
  security_groups = [aws_security_group.allow_ssh_http_tls.id]

  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }

  # listener {
  #   instance_port = 443
  #   instance_protocol = "https"
  #   lb_port = 443
  #   lb_protocol = "https"
  # }

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    target = "HTTP:80/"
    interval = 30
  }

  # instances = [ aws_instance.helloword.id ]
  cross_zone_load_balancing = true
  idle_timeout = 400
  connection_draining = true
  connection_draining_timeout = 400

  tags = {
    Name = "classic_elb"
  }
}
