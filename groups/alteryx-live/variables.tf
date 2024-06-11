
# ------------------------------------------------------------------------------
# Vault Variables
# ------------------------------------------------------------------------------
variable "vault_username" {
  type        = string
  description = "Username for connecting to Vault - usually supplied through TF_VARS"
}

variable "vault_password" {
  type        = string
  description = "Password for connecting to Vault - usually supplied through TF_VARS"
}

# ------------------------------------------------------------------------------
# AWS Variables
# ------------------------------------------------------------------------------
variable "aws_region" {
  type        = string
  description = "The AWS region in which resources will be administered"
}

variable "aws_profile" {
  type        = string
  description = "The AWS profile to use"
}

variable "aws_account" {
  type        = string
  description = "The name of the AWS Account in which resources will be administered"
}

# ------------------------------------------------------------------------------
# AWS Variables - Shorthand
# ------------------------------------------------------------------------------

variable "account" {
  type        = string
  description = "Short version of the name of the AWS Account in which resources will be administered"
}

variable "region" {
  type        = string
  description = "Short version of the name of the AWS region in which resources will be administered"
}

# ------------------------------------------------------------------------------
# Environment Variables
# ------------------------------------------------------------------------------

variable "application" {
  type        = string
  description = "The name of the application"
}

variable "application_environment" {
  type        = string
  description = "The specific application environment e.g. alteryx-live"
}

variable "environment" {
  type        = string
  description = "The name of the environment"
}

variable "domain_name" {
  type        = string
  description = "The name of the environment"
  default     = "*.companieshouse.gov.uk"
}

variable "default_log_group_retention_in_days" {
  type        = number
  default     = 365
  description = "Total days to retain logs in CloudWatch log group if not specified for specific logs"
}

# ------------------------------------------------------------------------------
# EBS Variables
# ------------------------------------------------------------------------------

variable "ebs_optimized" {
  description = "If true, the launched EC2 instance will be EBS-optimized"
  type        = bool
  default     = true
}

variable "delete_on_termination" {
  type        = string
  default     = "false"
  description = "EBS delete on termination"
}

variable "ebs_encrypted" {
  type        = string
  default     = "true"
  description = "EBS encrypted"
}

variable "volume_type" {
  type        = string
  default     = "gp3"
  description = "EBS volume type"
}

# ------------------------------------------------------------------------------
# Alteryx Server EC2 Variables
# ------------------------------------------------------------------------------
variable "alteryx_server_instance_type" {
  type        = string
  description = "The size of the alteryxlication EC2 instance"
}

variable "alteryx_server_instance_count" {
  description = "Name to be used on all resources as prefix"
  type        = string
}

variable "alteryx_server_ami_id" {
  default     = ""
  type        = string
  description = "ID of the AMI to use for alteryxlication server.This will take precedence if provided"
}

variable "alteryx_server_ami_version_pattern" {
  default     = "\\d.\\d.\\d"
  description = "The pattern with which to match alteryx-server AMIs. Used when no AMI ID is provided"
  type        = string
}

variable "alteryx_server_private_ip" {
  type        = string
  description = "Private IP address to associate with the alteryx instance"
}

variable "alteryx_server_storage_gb" {
  type        = string
  description = "Total default storage required on the EC2 instance"
}

variable "alteryx_server_additional_storage_gb" {
  type        = string
  description = "Total additional storage required on the EC2 instance"
}

variable "alteryx_server_detailed_monitoring" {
  description = "If true, the launched EC2 instance will have detailed monitoring enabled"
  type        = bool
  default     = false
}

variable "alteryx_server_get_password_data" {
  description = "If true, wait for password data to become available and retrieve it."
  type        = bool
  default     = false
}

variable "alteryx_server_cw_logs" {
  type        = map(any)
  description = "Map of log file information; used to create log groups, IAM permissions and passed to the application to configure remote logging"
  default     = {}
}

# ------------------------------------------------------------------------------
# Alteryx Worker EC2 Variables
# ------------------------------------------------------------------------------
variable "alteryx_worker_instance_type" {
  type        = string
  description = "The size of the alteryxlication EC2 instance"
}

variable "alteryx_worker_instance_count" {
  description = "Name to be used on all resources as prefix"
  type        = string
}


variable "alteryx_worker_ami_id" {
default     = ""
  type        = string
  description = "ID of the AMI to use for alteryxlication worker. This will take precedence if provided"
}

variable "alteryx_worker_ami_version_pattern" {
  default     = "\\d.\\d.\\d"
  description = "The pattern with which to match alteryx-worker AMIs. Used when no AMI ID is provided"
  type        = string
}

variable "alteryx_worker_private_ip" {
  type        = string
  description = "Private IP address to associate with the alteryx worker instance"
}

variable "alteryx_worker_storage_gb" {
  type        = string
  description = "Total default storage required on the EC2 instance"
}

variable "alteryx_worker_detailed_monitoring" {
  description = "If true, the launched EC2 instance will have detailed monitoring enabled"
  type        = bool
  default     = false
}

variable "alteryx_worker_get_password_data" {
  description = "If true, wait for password data to become available and retrieve it."
  type        = bool
  default     = false
}

variable "alteryx_worker_cw_logs" {
  type        = map(any)
  description = "Map of log file information; used to create log groups, IAM permissions and passed to the application to configure remote logging"
  default     = {}
}

variable "repository_name" {
  default     = "alteryx-terraform"
  description = "The name of the repository in which we're operating"
  type        = string
}

# ------------------------------------------------------------------------------
# Alteryx Server ALB Variables
# ------------------------------------------------------------------------------

variable "ssl_certificate_name" {
  type        = string
  description = "The name of an existing ACM certificate to use for the ELB SSL listener. Setting this disables certificate creation"
}
