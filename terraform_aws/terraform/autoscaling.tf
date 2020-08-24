resource "aws_launch_configuration" "helloworld_launch_conf" {
  name_prefix = "helloworld"
  image_id = lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.micro"
  key_name = aws_key_pair.temp_key.key_name
  security_groups = [aws_security_group.allow_ssh_http_tls.id]
}

resource "aws_autoscaling_group" "helloworld_autoscaling" {
  name = "helloworld_autoscaling"
  force_delete = true
  vpc_zone_identifier = [ aws_subnet.my-vpc-public-1.id,
                          aws_subnet.my-vpc-public-2.id,
                          aws_subnet.my-vpc-public-3.id
                        ]
  launch_configuration = aws_launch_configuration.helloworld_launch_conf.name
  min_size = 2
  max_size = 2
  health_check_grace_period = 300
  health_check_type = "EC2"
  tag {
    key = "Name"
    value = "helloworld_launch_conf"
    propagate_at_launch = true
  }
}

# resource "aws_autoscaling_policy" "cpu_policy" {
#   name = "cpu_policy"
#   autoscaling_group_name = aws_autoscaling_group.helloworld_autoscaling.name
#   adjustment_type = "ChangeInCapacity"
#   scaling_adjustment = "1"
#   cooldown = "300"
#   policy_type = "SimpleScaling"
# }
