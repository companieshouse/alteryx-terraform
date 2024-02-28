#Alteryx Server

resource "aws_cloudwatch_metric_alarm" "alteryx_sb_server_cpu90" {
  alarm_name                = "WARNING-alteryx-sb-server-CPUUtilization"
  evaluation_periods        = "1"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  metric_name               = "cpu_usage_system"
  namespace                 = "alteryx/sandbox"
  period                    = "60"
  statistic                 = "Maximum"
  threshold                 = "90"
  alarm_description         = "This metric monitors ec2 cpu utilization system"
  insufficient_data_actions = []
  alarm_actions             = [aws_sns_topic.alteryx_sandbox.arn]
  ok_actions                = [aws_sns_topic.alteryx_sandbox.arn]

    dimensions = {
    InstanceId = module.alteryx_server_ec2[0].id[0]
  }
  depends_on = [
    module.alteryx_server_ec2
  ]
}

resource "aws_cloudwatch_metric_alarm" "alteryx_sb_server_cpuuser90" {
  alarm_name                = "WARNING-alteryx-sb-server-CPUUtilizationUser"
  evaluation_periods        = "1"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  metric_name               = "cpu_usage_user"
  namespace                 = "alteryx/sandbox"
  period                    = "60"
  statistic                 = "Maximum"
  threshold                 = "90"
  alarm_description         = "This metric monitors ec2 cpu utilization user"
  insufficient_data_actions = []
  alarm_actions             = [aws_sns_topic.alteryx_sandbox.arn]
  ok_actions                = [aws_sns_topic.alteryx_sandbox.arn]

    dimensions = {
    InstanceId = module.alteryx_server_ec2[0].id[0]
  }
  depends_on = [
    module.alteryx_server_ec2
  ]
}

resource "aws_cloudwatch_metric_alarm" "alteryx_sb_server_cpu95" {
  
  alarm_name                = "CRITICAL-alteryx-sb-server-CPUUtilization"
  evaluation_periods        = "1"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  metric_name               = "cpu_usage_system"
  namespace                 = "alteryx/sandbox"
  period                    = "30"
  statistic                 = "Maximum"
  threshold                 = "95"
  alarm_description         = "This metric monitors ec2 cpu utilization system"
  insufficient_data_actions = []
  alarm_actions             = [aws_sns_topic.alteryx_sandbox.arn]
  ok_actions                = [aws_sns_topic.alteryx_sandbox.arn]

    dimensions = {
    InstanceId = module.alteryx_server_ec2[0].id[0]
  }
  depends_on = [
    module.alteryx_server_ec2
  ]
}

resource "aws_cloudwatch_metric_alarm" "alteryx_sb_server_cpu95user" {
  
  alarm_name                = "CRITICAL-alteryx-sb-server-CPUUtilizationUser"
  evaluation_periods        = "1"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  metric_name               = "cpu_usage_user"
  namespace                 = "alteryx/sandbox"
  period                    = "30"
  statistic                 = "Maximum"
  threshold                 = "95"
  alarm_description         = "This metric monitors ec2 cpu utilization user"
  insufficient_data_actions = []
  alarm_actions             = [aws_sns_topic.alteryx_sandbox.arn]
  ok_actions                = [aws_sns_topic.alteryx_sandbox.arn]

    dimensions = {
    InstanceId = module.alteryx_server_ec2[0].id[0]
  }
  depends_on = [
    module.alteryx_server_ec2
  ]
}

resource "aws_cloudwatch_metric_alarm" "alteryx_sb_server_mem_used90" {
  
  alarm_name                = "WARNING-alteryx-sb-server-mem_used"
  evaluation_periods        = "1"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  metric_name               = "mem_used_percent"
  namespace                 = "alteryx/sandbox"
  period                    = "60"
  statistic                 = "Maximum"
  threshold                 = "90"
  alarm_description         = "This metric monitors memory utilization"
  insufficient_data_actions = []
  alarm_actions             = [aws_sns_topic.alteryx_sandbox.arn]
  ok_actions                = [aws_sns_topic.alteryx_sandbox.arn]

    dimensions = {
    InstanceId = module.alteryx_server_ec2[0].id[0]
  }
  depends_on = [
    module.alteryx_server_ec2
  ]
}

resource "aws_cloudwatch_metric_alarm" "alteryx_sb_server_mem_used95" {
  
  alarm_name                = "CRITICAL-alteryx-sb-server-mem_used"
  evaluation_periods        = "1"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  metric_name               = "mem_used_percent"
  namespace                 = "alteryx/sandbox"
  period                    = "60"
  statistic                 = "Maximum"
  threshold                 = "95"
  alarm_description         = "This metric monitors memory utilization"
  insufficient_data_actions = []
  alarm_actions             = [aws_sns_topic.alteryx_sandbox.arn]
  ok_actions                = [aws_sns_topic.alteryx_sandbox.arn]

    dimensions = {
    InstanceId = module.alteryx_server_ec2[0].id[0]
  }
  depends_on = [
    module.alteryx_server_ec2
  ]
}

resource "aws_cloudwatch_metric_alarm" "alteryx_sb_server_StatusCheckFailed" {
  
  alarm_name                = "CRITICAL-alteryx-sb-server-StatusCheckFailed"
  evaluation_periods        = "1"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  metric_name               = "StatusCheckFailed"
  namespace                 = "alteryx/sandbox"
  period                    = "300"
  statistic                 = "Maximum"
  threshold                 = "1"
  alarm_description         = "This metric monitors StatusCheckFailed"
  insufficient_data_actions = []
  alarm_actions             = [aws_sns_topic.alteryx_sandbox.arn]
  ok_actions                = [aws_sns_topic.alteryx_sandbox.arn]

    dimensions = {
    InstanceId = module.alteryx_server_ec2[0].id[0]
  }
  depends_on = [
    module.alteryx_server_ec2
  ]
}

#Alteryx Worker

resource "aws_cloudwatch_metric_alarm" "alteryx_sb_worker_cpu90" {
  alarm_name                = "WARNING-alteryx-sb-worker-CPUUtilization"
  evaluation_periods        = "1"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  metric_name               = "cpu_usage_system"
  namespace                 = "alteryx/sandbox"
  period                    = "60"
  statistic                 = "Maximum"
  threshold                 = "90"
  alarm_description         = "This metric monitors ec2 cpu utilization system"
  insufficient_data_actions = []
  alarm_actions             = [aws_sns_topic.alteryx_sandbox.arn]
  ok_actions                = [aws_sns_topic.alteryx_sandbox.arn]

    dimensions = {
    InstanceId = module.alteryx_worker_ec2[0].id[0]
  }
  depends_on = [
    module.alteryx_worker_ec2
  ]
}

resource "aws_cloudwatch_metric_alarm" "alteryx_sb_worker_cpuuser90" {
  alarm_name                = "WARNING-alteryx-sb-worker-CPUUtilizationUser"
  evaluation_periods        = "1"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  metric_name               = "cpu_usage_user"
  namespace                 = "alteryx/sandbox"
  period                    = "60"
  statistic                 = "Maximum"
  threshold                 = "90"
  alarm_description         = "This metric monitors ec2 cpu utilization user"
  insufficient_data_actions = []
  alarm_actions             = [aws_sns_topic.alteryx_sandbox.arn]
  ok_actions                = [aws_sns_topic.alteryx_sandbox.arn]

    dimensions = {
    InstanceId = module.alteryx_worker_ec2[0].id[0]
  }
  depends_on = [
    module.alteryx_worker_ec2
  ]
}

resource "aws_cloudwatch_metric_alarm" "alteryx_sb_worker_cpu95" {
  
  alarm_name                = "CRITICAL-alteryx-sb-worker-CPUUtilization"
  evaluation_periods        = "1"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  metric_name               = "cpu_usage_system"
  namespace                 = "alteryx/sandbox"
  period                    = "30"
  statistic                 = "Maximum"
  threshold                 = "95"
  alarm_description         = "This metric monitors ec2 cpu utilization system"
  insufficient_data_actions = []
  alarm_actions             = [aws_sns_topic.alteryx_sandbox.arn]
  ok_actions                = [aws_sns_topic.alteryx_sandbox.arn]

    dimensions = {
    InstanceId = module.alteryx_worker_ec2[0].id[0]
  }
  depends_on = [
    module.alteryx_worker_ec2
  ]
}

resource "aws_cloudwatch_metric_alarm" "alteryx_sb_worker_cpu95user" {
  
  alarm_name                = "CRITICAL-alteryx-sb-worker-CPUUtilizationUser"
  evaluation_periods        = "1"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  metric_name               = "cpu_usage_user"
  namespace                 = "alteryx/sandbox"
  period                    = "30"
  statistic                 = "Maximum"
  threshold                 = "95"
  alarm_description         = "This metric monitors ec2 cpu utilization user"
  insufficient_data_actions = []
  alarm_actions             = [aws_sns_topic.alteryx_sandbox.arn]
  ok_actions                = [aws_sns_topic.alteryx_sandbox.arn]

    dimensions = {
    InstanceId = module.alteryx_worker_ec2[0].id[0]
  }
  depends_on = [
    module.alteryx_worker_ec2
  ]
}

resource "aws_cloudwatch_metric_alarm" "alteryx_sb_worker_mem_used90" {
  
  alarm_name                = "WARNING-alteryx-sb-worker-mem_used"
  evaluation_periods        = "1"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  metric_name               = "mem_used_percent"
  namespace                 = "alteryx/sandbox"
  period                    = "60"
  statistic                 = "Maximum"
  threshold                 = "90"
  alarm_description         = "This metric monitors memory utilization"
  insufficient_data_actions = []
  alarm_actions             = [aws_sns_topic.alteryx_sandbox.arn]
  ok_actions                = [aws_sns_topic.alteryx_sandbox.arn]

    dimensions = {
    InstanceId = module.alteryx_worker_ec2[0].id[0]
  }
  depends_on = [
    module.alteryx_worker_ec2
  ]
}

resource "aws_cloudwatch_metric_alarm" "alteryx_sb_worker_mem_used95" {
  
  alarm_name                = "CRITICAL-alteryx-sb-worker-mem_used"
  evaluation_periods        = "1"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  metric_name               = "mem_used_percent"
  namespace                 = "alteryx/sandbox"
  period                    = "60"
  statistic                 = "Maximum"
  threshold                 = "95"
  alarm_description         = "This metric monitors memory utilization"
  insufficient_data_actions = []
  alarm_actions             = [aws_sns_topic.alteryx_sandbox.arn]
  ok_actions                = [aws_sns_topic.alteryx_sandbox.arn]

    dimensions = {
    InstanceId = module.alteryx_worker_ec2[0].id[0]
  }
  depends_on = [
    module.alteryx_worker_ec2
  ]
}

resource "aws_cloudwatch_metric_alarm" "alteryx_sb_worker_StatusCheckFailed" {
  
  alarm_name                = "CRITICAL-alteryx-sb-worker-StatusCheckFailed"
  evaluation_periods        = "1"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  metric_name               = "StatusCheckFailed"
  namespace                 = "alteryx/sandbox"
  period                    = "300"
  statistic                 = "Maximum"
  threshold                 = "1"
  alarm_description         = "This metric monitors StatusCheckFailed"
  insufficient_data_actions = []
  alarm_actions             = [aws_sns_topic.alteryx_sandbox.arn]
  ok_actions                = [aws_sns_topic.alteryx_sandbox.arn]

    dimensions = {
    InstanceId = module.alteryx_worker_ec2[0].id[0]
  }
  depends_on = [
    module.alteryx_worker_ec2
  ]
}
