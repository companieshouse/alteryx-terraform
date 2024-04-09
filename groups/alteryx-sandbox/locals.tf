# ------------------------------------------------------------------------
# Locals 
# ------------------------------------------------------------------------
locals {
  internal_cidrs              = values(data.vault_generic_secret.internal_cidrs.data)
  alteryx_key                 = local.secrets.public-key
  azure_dc_cidrs              = jsondecode(local.secrets.azure_dc_cidrs)
  concourse_cidrs             = local.automation_subnet_cidrs
  ansible_cidr_blocks         = join(",", "${local.internal_cidrs}", "${local.concourse_cidrs}")
  account_ids_secrets         = jsondecode(data.vault_generic_secret.account_ids.data_json)
  vpc_name                    = local.secrets.vpc_name
  automation_subnet           = local.secrets.automation_subnets_pattern
  alteryx_subnets_pattern     = local.secrets.alteryx_subnets_pattern
  alteryx_server_ami_id       = var.alteryx_server_ami_id == "" ? data.aws_ami.alteryx_server_ami[0].id : var.alteryx_server_ami_id
  alteryx_server_ami_owner_id = local.account_ids_secrets["shared-services"]
  secrets                     = data.vault_generic_secret.secrets.data
  alteryx_worker_ami_id       = var.alteryx_worker_ami_id == "" ? data.aws_ami.alteryx_worker_ami[0].id : var.alteryx_worker_ami_id
  alteryx_worker_ami_owner_id = local.account_ids_secrets["shared-services"]

  kms_keys_data          = data.vault_generic_secret.kms_keys.data
  security_kms_keys_data = data.vault_generic_secret.security_kms_keys.data
  logs_kms_key_id        = local.kms_keys_data["logs"]
  ebs_kms_key_arn        = local.kms_keys_data["ebs"]
  ssm_kms_key_id         = local.security_kms_keys_data["session-manager-kms-key-arn"]

  security_s3_data            = data.vault_generic_secret.security_s3_buckets.data
  session_manager_bucket_name = local.security_s3_data["session-manager-bucket-name"]


  sns_email_secret = data.vault_generic_secret.sns_email.data
  sns_email        = local.sns_email_secret["email"]

  internal_fqdn = "${replace(var.aws_account, "-", "")}.aws.internal"

  #For each log map passed, add an extra kv for the log group name
  alteryx_server_cw_logs    = { for log, map in var.alteryx_server_cw_logs : log => merge(map, { "log_group_name" = "${var.application}-${var.application_environment}-server-${log}" }) }
  alteryx_server_log_groups = compact([for log, map in local.alteryx_server_cw_logs : lookup(map, "log_group_name", "")])

  alteryx_worker_cw_logs    = { for log, map in var.alteryx_worker_cw_logs : log => merge(map, { "log_group_name" = "${var.application}-${var.application_environment}-worker-${log}" }) }
  alteryx_worker_log_groups = compact([for log, map in local.alteryx_worker_cw_logs : lookup(map, "log_group_name", "")])

  automation_subnets = values(data.aws_subnet.automation)
  alteryx_subnets = values(data.aws_subnet.alteryx)

  automation_subnet_cidrs = values(zipmap(
    local.automation_subnets.*.availability_zone,
    local.automation_subnets.*.cidr_block
  ))

 alteryx_subnet_cidrs = values(zipmap(
    local.alteryx_subnets.*.availability_zone,
    local.alteryx_subnets.*.cidr_block
  ))

  # alteryx_subnet_cidrs = values(local.alteryx_subnets.*.cidr_block)

  dns_zone_private_zone  = data.aws_route53_zone.private_zone
  dns_zone_name          = data.aws_route53_zone.private_zone.name
  dns_zone_id            = data.aws_route53_zone.private_zone.zone_id
  create_ssl_certificate = var.ssl_certificate_name == "" ? true : false
  ssl_certificate_arn    = var.ssl_certificate_name == "" ? aws_acm_certificate_validation.certificate[0].certificate_arn : data.aws_acm_certificate.certificate[0].arn

  default_tags = {
    Terraform   = "true"
    Application = upper(var.application)
    Region      = var.aws_region
    Account     = var.aws_account
  }
}
