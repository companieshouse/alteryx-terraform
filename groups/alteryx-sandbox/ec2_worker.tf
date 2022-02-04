# ------------------------------------------------------------------------------
# Applicatoin Security Group and rules
# ------------------------------------------------------------------------------
module "alteryx_worker_ec2_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 3.0"

  name        = "sgr-${var.application}-${var.application_environment}-server"
  description = "Security group for the ${var.application_environment} ${var.application} Worker EC2"
  vpc_id      = data.aws_vpc.vpc.id

  ingress_cidr_blocks = local.internal_cidrs
  ingress_rules       = ["rdp-tcp", "rdp-udp"]

  egress_rules = ["all-all"]

  tags = merge(
    local.default_tags,
    map(
      "ServiceTeam", "Data",
    )
  )
}

resource "aws_cloudwatch_log_group" "alteryx_worker" {
  for_each = local.alteryx_worker_cw_logs

  name              = each.value["log_group_name"]
  retention_in_days = lookup(each.value, "log_group_retention", var.default_log_group_retention_in_days)
  kms_key_id        = lookup(each.value, "kms_key_id", local.logs_kms_key_id)

  tags = merge(
    local.default_tags,
    map(
      "Name", "${var.application}-${var.application_environment}-worker",
      "ServiceTeam", "Data",
    )
  )
}

module "alteryx_worker_ec2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "2.19.0"

  count = var.alteryx_worker_instance_count

  name              = "${var.application}-${var.application_environment}-worker"
  ami               = var.alteryx_worker_ami
  instance_type     = var.alteryx_worker_instance_type
  key_name          = aws_key_pair.alteryx_keypair.key_name
  monitoring        = var.alteryx_worker_detailed_monitoring
  get_password_data = var.alteryx_worker_get_password_data
  vpc_security_group_ids = [
    module.alteryx_worker_ec2_security_group.this_security_group_id
  ]
  subnet_id            = [for sub in data.aws_subnet.alteryx : sub.id][count.index + 1]
  iam_instance_profile = module.alteryx_worker_profile.aws_iam_instance_profile.name
  ebs_optimized        = var.ebs_optimized
  private_ip           = cidrhost([for sub in data.aws_subnet.alteryx : sub.cidr_block][count.index + 1], 5)

  root_block_device = [
    {
      delete_on_termination = var.delete_on_termination
      volume_size           = var.alteryx_worker_storage_gb
      volume_type           = var.volume_type
      encrypted             = var.ebs_encrypted
      kms_key_id            = local.ebs_kms_key_arn
    }
  ]

  tags = merge(
    local.default_tags,
    map(
      "Name", "${var.application}-${var.application_environment}-worker",
      "ServiceTeam", "Data",
      "AlteryxRole", "${var.application}-${var.application_environment}-worker",
      "Backup", "backup21",
      "BackupApp", var.application
    )
  )

  volume_tags = merge(
    local.default_tags,
    map(
      "Name", "${var.application}-${var.application_environment}-worker",
      "ServiceTeam", "Data",
      "AlteryxRole", "${var.application}-${var.application_environment}-worker",
      "Backup", "backup21",
      "BackupApp", var.application
    )
  )
}
