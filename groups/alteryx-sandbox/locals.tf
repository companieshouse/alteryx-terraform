# ------------------------------------------------------------------------
# Locals
# ------------------------------------------------------------------------
locals {
  internal_cidrs   = values(data.vault_generic_secret.internal_cidrs.data)
  alteryx_ec2_data = data.vault_generic_secret.alteryx_ec2_data.data

  kms_keys_data          = data.vault_generic_secret.kms_keys.data
  security_kms_keys_data = data.vault_generic_secret.security_kms_keys.data
  logs_kms_key_id        = local.kms_keys_data["logs"]
  ebs_kms_key_arn        = local.kms_keys_data["ebs"]
  ssm_kms_key_id         = local.security_kms_keys_data["session-manager-kms-key-arn"]

  security_s3_data            = data.vault_generic_secret.security_s3_buckets.data
  session_manager_bucket_name = local.security_s3_data["session-manager-bucket-name"]

  internal_fqdn = "${replace(var.aws_account, "-", "")}.aws.internal"

  #For each log map passed, add an extra kv for the log group name
  alteryx_server_cw_logs    = { for log, map in var.alteryx_server_cw_logs : log => merge(map, { "log_group_name" = "${var.application}-chips-estor-${log}" }) }
  alteryx_server_log_groups = compact([for log, map in local.alteryx_server_cw_logs : lookup(map, "log_group_name", "")])

  alteryx_worker_cw_logs    = { for log, map in var.alteryx_worker_cw_logs : log => merge(map, { "log_group_name" = "${var.application}-chips-estor-${log}" }) }
  alteryx_worker_log_groups = compact([for log, map in local.alteryx_worker_cw_logs : lookup(map, "log_group_name", "")])

  default_tags = {
    Terraform   = "true"
    Application = upper(var.application)
    Region      = var.aws_region
    Account     = var.aws_account
  }
}