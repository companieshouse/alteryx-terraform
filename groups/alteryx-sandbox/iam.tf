module "alteryx_server_profile" {
  source = "git@github.com:companieshouse/terraform-modules//aws/instance_profile?ref=tags/1.0.59"

  name       = "${var.application}-${var.application_environment}-server-app-profile"
  enable_SSM = true
  kms_key_refs = [
    "alias/${var.account}/${var.region}/ebs",
    local.ssm_kms_key_id
  ]
  s3_buckets_write = [local.session_manager_bucket_name]
  cw_log_group_arns = length(local.alteryx_server_log_groups) > 0 ? flatten([
    formatlist(
      "arn:aws:logs:%s:%s:log-group:%s:*:*",
      var.aws_region,
      data.aws_caller_identity.current.account_id,
      local.alteryx_server_log_groups
    ),
    formatlist("arn:aws:logs:%s:%s:log-group:%s:*",
      var.aws_region,
      data.aws_caller_identity.current.account_id,
      local.alteryx_server_log_groups
    ),
  ]) : null

  custom_statements = [
    {
      sid       = "CloudwatchMetrics"
      effect    = "Allow"
      resources = ["*"]
      actions = [
        "cloudwatch:PutMetricData"
      ]
    },
    {
      sid     = "S3AllowListGet"
      effect  = "Allow"
      resources = ["${data.aws_s3_bucket.resources.arn}/"]
      actions = [
        "s3:ListBucket",
        "s3:GetObject"
      ]
    },
  ]
}

module "alteryx_worker_profile" {
  source = "git@github.com:companieshouse/terraform-modules//aws/instance_profile?ref=tags/1.0.59"

  name       = "${var.application}-${var.application_environment}-worker-app-profile"
  enable_SSM = true
  kms_key_refs = [
    "alias/${var.account}/${var.region}/ebs",
    local.ssm_kms_key_id
  ]
  s3_buckets_write = [local.session_manager_bucket_name]
  cw_log_group_arns = length(local.alteryx_worker_log_groups) > 0 ? flatten([
    formatlist(
      "arn:aws:logs:%s:%s:log-group:%s:*:*",
      var.aws_region,
      data.aws_caller_identity.current.account_id,
      local.alteryx_worker_log_groups
    ),
    formatlist("arn:aws:logs:%s:%s:log-group:%s:*",
      var.aws_region,
      data.aws_caller_identity.current.account_id,
      local.alteryx_worker_log_groups
    ),
  ]) : null

  custom_statements = [
    {
      sid       = "CloudwatchMetrics"
      effect    = "Allow"
      resources = ["*"]
      actions = [
        "cloudwatch:PutMetricData"
      ]
    }
  ]
}