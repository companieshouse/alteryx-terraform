data "aws_caller_identity" "current" {}

data "aws_vpc" "vpc" {
  tags = {
    Name = "vpc-${var.aws_account}"
  }
}

data "aws_subnets" "alteryx" {

  filter {
    name   = "tag:Name"
    values = ["sub-alteryx-c"]
  }
}

data "aws_subnet" "alteryx" {
  for_each = toset(data.aws_subnets.alteryx.ids)
  id       = each.value
}

data "vault_generic_secret" "internal_cidrs" {
  path = "aws-accounts/network/internal_cidr_ranges"
}

data "vault_generic_secret" "sns_email" {
  path = "applications/${var.aws_account}-${var.aws_region}/${var.application}/sns/"
}

data "vault_generic_secret" "secrets" {
  path = "applications/${var.aws_account}-${var.aws_region}/${var.application}/${var.repository_name}"
}

data "aws_vpc" "automation" {
  filter {
    name   = "tag:Name"
    values = [local.vpc_name]
  }
}

data "aws_subnets" "automation" {

  filter {
    name   = "tag:Name"
    values = [local.automation_subnet]
  }
}

data "aws_subnet" "automation" {
  for_each = toset(data.aws_subnets.automation.ids)
  id       = each.value
}

data "aws_subnets" "subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }

  filter {
    name   = "tag:Name"
    values = [local.alteryx_subnets_pattern]
  }
}

data "aws_kms_key" "ebs" {
  key_id = "alias/${var.account}/${var.region}/ebs"
}

data "vault_generic_secret" "kms_keys" {
  path = "aws-accounts/${var.aws_account}/kms"
}

data "aws_route53_zone" "private_zone" {
  name         = local.internal_fqdn
  private_zone = true
}

data "vault_generic_secret" "security_kms_keys" {
  path = "aws-accounts/security/kms"
}

data "vault_generic_secret" "security_s3_buckets" {
  path = "aws-accounts/security/s3"
}

data "aws_acm_certificate" "certificate" {
  count = local.create_ssl_certificate ? 0 : 1

  domain      = var.ssl_certificate_name
  statuses    = ["ISSUED"]
  most_recent = true
}

data "aws_s3_bucket" "resources" {
  bucket = "${var.aws_account}.${var.aws_region}.resources.ch.gov.uk"
}

data "aws_ami" "alteryx_server_ami" {
  count = var.alteryx_server_ami_id == "" ? 1 : 0

  most_recent = true
  name_regex  = "^win2019-base-${var.alteryx_server_ami_version_pattern}$"
  owners      = [local.alteryx_server_ami_owner_id]
}

data "aws_ami" "alteryx_worker_ami" {
  count = var.alteryx_worker_ami_id == "" ? 1 : 0

  most_recent = true
  name_regex  = "^win2019-base-${var.alteryx_worker_ami_version_pattern}$"
  owners      = [local.alteryx_worker_ami_owner_id]
}

data "vault_generic_secret" "account_ids" {
  path = "aws-accounts/account-ids"
}

data "aws_ec2_managed_prefix_list" "admin" {
  name = "administration-cidr-ranges"
}

data "aws_ec2_managed_prefix_list" "ci" {
  name = "shared-services-management-cidrs"
}
