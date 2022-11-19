
resource "aws_cloudwatch_metric_alarm" "ec2_cpu" {
  for_each = var.use_watch ? var.server_list : {}
  alarm_name                = "${each.key}-cpu-utilization"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = "120" #seconds
  statistic                 = "Average"
  threshold                 = "80"
  alarm_description         = "This metric monitors ec2 cpu utilization"
  insufficient_data_actions = []
  dimensions = {
    InstanceId = aws_instance.server[each.key].id
  }
}
