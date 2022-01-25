module "alteryx_server_profile" {
  source = "git@github.com:companieshouse/terraform-modules//aws/instance_profile?ref=tags/1.0.59"

  name       = "${var.application}-${var.application_environment}-server-app-profile"
  enable_SSM = true
  kms_key_refs = [
    "alias/${var.account}/${var.region}/ebs",
    local.ssm_kms_key_id
  ]
  s3_buckets_write = [local.session_manager_bucket_name]
}

# module "alteryx_worker_profile" {
#   source = "git@github.com:companieshouse/terraform-modules//aws/instance_profile?ref=tags/1.0.59"

#   name       = "${var.application}-${var.application_environment}-worker-app-profile"
#   enable_SSM = true
#   kms_key_refs = [
#     "alias/${var.account}/${var.region}/ebs",
#     local.ssm_kms_key_id
#   ]
#   s3_buckets_write = [local.session_manager_bucket_name]
# }