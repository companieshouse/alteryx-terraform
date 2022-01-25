# ------------------------------------------------------------------------------
# Applicatoin Security Group and rules
# ------------------------------------------------------------------------------
module "alteryx_server_ec2_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 3.0"

  name        = "sgr-${var.application}-${var.application_environment}-server"
  description = "Security group for the ${var.application_environment} ${var.application} Server EC2"
  vpc_id      = data.aws_vpc.vpc.id

  ingress_cidr_blocks = local.internal_cidrs
  ingress_rules       = ["http-80-tcp", "https-443-tcp", "rdp-tcp", "rdp-udp"]

  computed_ingress_with_source_security_group_id = [
    {
      rule                     = "http-80-tcp"
      source_security_group_id = module.alteryx_worker_ec2_security_group.this_security_group_id
    },
    {
      rule                     = "https-443-tcp"
      source_security_group_id = module.alteryx_worker_ec2_security_group.this_security_group_id
    }
  ]
  number_of_computed_ingress_with_source_security_group_id = 2

  egress_rules = ["all-all"]

  tags = merge(
    local.default_tags,
    map(
      "ServiceTeam", "Data",
    )
  )
}

module "alteryx_server_ec2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "2.19.0"

  count = var.alteryx_server_instance_count

  name              = "${var.application}-${var.application_environment}-server"
  ami               = var.alteryx_server_ami
  instance_type     = var.alteryx_server_instance_type
  key_name          = aws_key_pair.alteryx_keypair.key_name
  monitoring        = var.alteryx_server_detailed_monitoring
  get_password_data = var.alteryx_server_get_password_data
  vpc_security_group_ids = [
    module.alteryx_server_ec2_security_group.this_security_group_id
  ]
  subnet_id            = [for sub in data.aws_subnet.alteryx : sub.id][count.index]
  iam_instance_profile = module.alteryx_server_profile.aws_iam_instance_profile.name
  ebs_optimized        = var.ebs_optimized
  private_ip           = cidrhost([for sub in data.aws_subnet.alteryx : sub.cidr_block][count.index], 5)

  root_block_device = [
    {
      delete_on_termination = var.delete_on_termination
      volume_size           = var.alteryx_server_storage_gb
      volume_type           = var.volume_type
      encrypted             = var.ebs_encrypted
      kms_key_id            = data.aws_kms_key.ebs.arn
    }
  ]

  ebs_block_device = [
    {
      delete_on_termination = var.delete_on_termination
      device_name           = "/dev/xvdf"
      encrypted             = var.ebs_encrypted
      volume_size           = var.alteryx_server_additional_storage_gb
      volume_type           = var.volume_type
      kms_key_id            = data.aws_kms_key.ebs.arn
    }
  ]

  tags = merge(
    local.default_tags,
    map(
      "Name", "${var.application}-${var.application_environment}-server",
      "ServiceTeam", "Data",
      "AlteryxRole", "${var.application}-${var.application_environment}-server",
      "Backup", "true",
      "BackupApp", var.application
    )
  )

  volume_tags = merge(
    local.default_tags,
    map(
      "Name", "${var.application}-${var.application_environment}-server",
      "ServiceTeam", "Data",
      "AlteryxRole", "${var.application}-${var.application_environment}-server",
      "Backup", "true",
      "BackupApp", var.application
    )
  )
}
