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
  ingress_with_cidr_blocks = [
    {
      from_port   = 135
      to_port     = 135
      protocol    = "tcp"
      description = "WMI Access"
      cidr_blocks = join(",", local.azure_dc_cidrs)
    },
    {
      from_port   = 49152
      to_port     = 65535
      protocol    = "tcp"
      description = "WMI Access"
      cidr_blocks = join(",", local.azure_dc_cidrs)
    },
    {
      from_port   = 5986
      to_port     = 5986
      protocol    = "tcp"
      description = "Ansible Access"
      cidr_blocks = local.ansible_cidr_blocks
    }
  ]

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

resource "aws_cloudwatch_log_group" "alteryx_server" {
  for_each = local.alteryx_server_cw_logs

  name              = each.value["log_group_name"]
  retention_in_days = lookup(each.value, "log_group_retention", var.default_log_group_retention_in_days)
  kms_key_id        = lookup(each.value, "kms_key_id", local.logs_kms_key_id)

  tags = merge(
    local.default_tags,
    map(
      "Name", "${var.application}-${var.application_environment}-server",
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
      kms_key_id            = local.ebs_kms_key_arn
    }
  ]

  ebs_block_device = [
    {
      delete_on_termination = var.delete_on_termination
      device_name           = "/dev/xvdf"
      encrypted             = var.ebs_encrypted
      volume_size           = var.alteryx_server_additional_storage_gb
      volume_type           = var.volume_type
      kms_key_id            = local.ebs_kms_key_arn
    }
  ]

  tags = merge(
    local.default_tags,
    map(
      "Name", "${var.application}-${var.application_environment}-server",
      "ServiceTeam", "Data",
      "AlteryxRole", "${var.application}-${var.application_environment}-server",
      "Backup", "backup21",
      "BackupApp", var.application
    )
  )

  volume_tags = merge(
    local.default_tags,
    map(
      "Name", "${var.application}-${var.application_environment}-server",
      "ServiceTeam", "Data",
      "AlteryxRole", "${var.application}-${var.application_environment}-server",
      "Backup", "backup21",
      "BackupApp", var.application
    )
  )

  user_data = <<EOF
<powershell>
# https://www.packer.io/docs/builders/amazon/ebs

Set-ExecutionPolicy Unrestricted -Scope LocalMachine -Force -ErrorAction Ignore

# Don't set this before Set-ExecutionPolicy as it throws an error
$ErrorActionPreference = "stop"

# Remove HTTP listener
Remove-Item -Path WSMan:\Localhost\listener\listener* -Recurse

# Create a self-signed certificate to let ssl work
$Cert = New-SelfSignedCertificate -CertstoreLocation Cert:\LocalMachine\My -DnsName "alteryx-sandbox-server"
New-Item -Path WSMan:\LocalHost\Listener -Transport HTTPS -Address * -CertificateThumbPrint $Cert.Thumbprint -Force

# Configure WinRM
cmd.exe /c winrm quickconfig -q
cmd.exe /c winrm set "winrm/config" '@{MaxTimeoutms="1800000"}'
cmd.exe /c winrm set "winrm/config/winrs" '@{MaxMemoryPerShellMB="1024"}'
cmd.exe /c winrm set "winrm/config/service" '@{AllowUnencrypted="true"}'
cmd.exe /c winrm set "winrm/config/client" '@{AllowUnencrypted="true"}'
cmd.exe /c winrm set "winrm/config/service/auth" '@{Basic="true"}'
cmd.exe /c winrm set "winrm/config/client/auth" '@{Basic="true"}'
cmd.exe /c winrm set "winrm/config/service/auth" '@{CredSSP="true"}'
cmd.exe /c winrm set "winrm/config/listener?Address=*+Transport=HTTPS" "@{Port=`"5986`";Hostname=`"alteryx-sandbox-server`";CertificateThumbprint=`"$($Cert.Thumbprint)`"}"
cmd.exe /c netsh advfirewall firewall set rule group="remote administration" new enable=yes

cmd.exe /c net stop winrm
cmd.exe /c sc config winrm start= auto
cmd.exe /c net start winrm

</powershell>
EOF
  
}
