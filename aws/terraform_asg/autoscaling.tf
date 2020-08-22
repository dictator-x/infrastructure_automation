resource "aws_launch_configuration" "helloworld_launch_conf" {
  name_prefix = "helloworld"
  image_id = lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.micro"
  key_name = aws_key_pair.temp_key.key_name
  security_groups = [aws_security_group.allow_traffic_from_elb.id]
  user_data = data.template_file.helloworld_http_server_script.rendered
}

resource "aws_autoscaling_group" "helloworld_autoscaling" {
  name = "helloworld_autoscaling"
  force_delete = true
  vpc_zone_identifier = data.aws_subnet_ids.private.ids
  launch_configuration = aws_launch_configuration.helloworld_launch_conf.name
  min_size = 3
  max_size = 3
  health_check_grace_period = 300
  # health_check_type = "EC2"
  health_check_type = "ELB"
  load_balancers = [ aws_elb.classic_elb.name ]
  tag {
    key = "Name"
    value = "helloworld_launch_conf"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_policy" "cpu_policy" {
  name = "cpu_policy"
  autoscaling_group_name = aws_autoscaling_group.helloworld_autoscaling.name
  adjustment_type = "ChangeInCapacity"
  scaling_adjustment = "1"
  cooldown = "300"
  policy_type = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "cpu_alarm" {
  alarm_name = "cup_alarm"
  alarm_description = "cpu_alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = "2"
  period = "120"
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  statistic = "Average"
  threshold = "30"
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.helloworld_autoscaling.name
  }
  alarm_actions = [ aws_autoscaling_policy.cpu_policy.arn ]
}


resource "aws_autoscaling_policy" "cup_policy_scaledown" {
  name = "cup_policy_scaledown"
  autoscaling_group_name = aws_autoscaling_group.helloworld_autoscaling.name
  adjustment_type = "ChangeInCapacity"
  scaling_adjustment = "-1"
  cooldown = "300"
  policy_type = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "cpu_alarm_scaledown" {
  alarm_name = "cup_alarm_scaledown"
  alarm_description = "cpu_alarm_scaledown"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods = "2"
  period = "120"
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  statistic = "Average"
  threshold = "5"
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.helloworld_autoscaling.name
  }
  alarm_actions = [ aws_autoscaling_policy.cup_policy_scaledown.arn ]
}
