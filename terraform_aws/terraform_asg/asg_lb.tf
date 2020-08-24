resource "aws_autoscaling_attachment" "asg_lb_http_attachment" {
  autoscaling_group_name = aws_autoscaling_group.helloworld_autoscaling.id
  alb_target_group_arn   = aws_lb_target_group.lb_http_target_group.arn
}

# resource "aws_autoscaling_attachment" "asg_elb_attachment" {
#   autoscaling_group_name = aws_autoscaling_group.helloworld_autoscaling.id
#   elb   = aws_elb.classic_elb.id
# }
