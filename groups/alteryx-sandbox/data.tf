data "aws_caller_identity" "current" {}

data "aws_vpc" "vpc" {
  tags = {
    Name = "vpc-${var.aws_account}"
  }
}

data "aws_subnet_ids" "alteryx" {
  vpc_id = data.aws_vpc.vpc.id
  filter {
    name   = "tag:Name"
    values = ["sub-alteryx-*"]
  }
}

data "aws_subnet" "alteryx" {
  for_each = data.aws_subnet_ids.alteryx.ids
  id       = each.value
}

data "vault_generic_secret" "internal_cidrs" {
  path = "aws-accounts/network/internal_cidr_ranges"
}

data "vault_generic_secret" "alteryx_ec2_data" {
  path = "applications/${var.aws_account}-${var.aws_region}/${var.application}/ec2"
}

data "vault_generic_secret" "azure_dc_cidrs" {
  path = "applications/${var.aws_account}-${var.aws_region}/${var.application}/azure_dc"
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

data "aws_acm_certificate" "acm_cert" {
  domain = var.domain_name
}

data "aws_s3_bucket" "resources" {
  bucket = "${var.aws_account}.${var.aws_region}.resources.ch.gov.uk"
}
