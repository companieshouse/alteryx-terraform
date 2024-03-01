#Alteryx Server

resource "aws_cloudwatch_metric_alarm" "alteryx_live_server_cpu95" {
  alarm_name                = "WARNING-alteryx-live-server-CPUUtilization"
  evaluation_periods        = "1"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = "60"
  statistic                 = "Maximum"
  threshold                 = "95"
  alarm_description         = "This metric monitors ec2 cpu utilization system"
  insufficient_data_actions = []
  alarm_actions             = [aws_sns_topic.alteryx_live.arn]
  ok_actions                = [aws_sns_topic.alteryx_live.arn]

  dimensions = {
    InstanceId = module.alteryx_server_ec2[0].id[0]
  }
  depends_on = [
    module.alteryx_server_ec2
  ]
}

resource "aws_cloudwatch_metric_alarm" "alteryx_live_server_StatusCheckFailed" {
  alarm_name                = "CRITICAL-alteryx-live-server-StatusCheckFailed"
  evaluation_periods        = "1"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  metric_name               = "StatusCheckFailed"
  namespace                 = "AWS/EC2"
  period                    = "300"
  statistic                 = "Maximum"
  threshold                 = "1"
  alarm_description         = "This metric monitors StatusCheckFailed"
  insufficient_data_actions = []
  alarm_actions             = [aws_sns_topic.alteryx_live.arn]
  ok_actions                = [aws_sns_topic.alteryx_live.arn]

  dimensions = {
    InstanceId = module.alteryx_server_ec2[0].id[0]
  }
  depends_on = [
    module.alteryx_server_ec2
  ]
}

#Alteryx Worker

resource "aws_cloudwatch_metric_alarm" "alteryx_live_worker_cpu95" {
  alarm_name                = "WARNING-alteryx-live-worker-CPUUtilization"
  evaluation_periods        = "1"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = "60"
  statistic                 = "Maximum"
  threshold                 = "95"
  alarm_description         = "This metric monitors ec2 cpu utilization system"
  insufficient_data_actions = []
  alarm_actions             = [aws_sns_topic.alteryx_live.arn]
  ok_actions                = [aws_sns_topic.alteryx_live.arn]

  dimensions = {
    InstanceId = module.alteryx_worker_ec2[0].id[0]
  }
  depends_on = [
    module.alteryx_worker_ec2
  ]
}

resource "aws_cloudwatch_metric_alarm" "alteryx_live_worker_StatusCheckFailed" {
  alarm_name                = "CRITICAL-alteryx-live-worker-StatusCheckFailed"
  evaluation_periods        = "1"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  metric_name               = "StatusCheckFailed"
  namespace                 = "AWS/EC2"
  period                    = "300"
  statistic                 = "Maximum"
  threshold                 = "1"
  alarm_description         = "This metric monitors StatusCheckFailed"
  insufficient_data_actions = []
  alarm_actions             = [aws_sns_topic.alteryx_live.arn]
  ok_actions                = [aws_sns_topic.alteryx_live.arn]

  dimensions = {
    InstanceId = module.alteryx_worker_ec2[0].id[0]
  }
  depends_on = [
    module.alteryx_worker_ec2
  ]
}
