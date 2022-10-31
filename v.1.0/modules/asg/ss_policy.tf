resource "aws_autoscaling_policy" "scale_out" {
  name                   = replace(local.name, "rtype", "scale_out_policy")
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.main.name
  policy_type            = "SimpleScaling"
}
resource "aws_cloudwatch_metric_alarm" "scale_out_alarm" {
  alarm_name          = "scale_out_terraform"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "80"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.main.name
  }
  actions_enabled   = true
  alarm_description = "This metric monitors ec2 cpu utilization"
  alarm_actions     = [aws_autoscaling_policy.scale_out.arn]
}
resource "aws_autoscaling_policy" "scale_in" {
  name                   = replace(local.name, "rtype", "scale_in_policy")
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.main.name
  policy_type            = "SimpleScaling"
}
resource "aws_cloudwatch_metric_alarm" "scale_in_alarm" {
  alarm_name          = "scale_in_terraform"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "40"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.main.name
  }
  actions_enabled   = true
  alarm_description = "This metric monitors ec2 cpu utilization"
  alarm_actions     = [aws_autoscaling_policy.scale_in.arn]
}