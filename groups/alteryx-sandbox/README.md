# aws-alteryx-sandbox-terraform

Worker code commented out but can be reinstated if a worker node is required for Sandbox environment.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0, < 0.14 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 0.3, < 4.0 |
| <a name="requirement_vault"></a> [vault](#requirement\_vault) | >= 2.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 0.3, < 4.0 |
| <a name="provider_vault"></a> [vault](#provider\_vault) | >= 2.0.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_app_ec2_security_group"></a> [app\_ec2\_security\_group](#module\_app\_ec2\_security\_group) | terraform-aws-modules/security-group/aws | ~> 3.0 |
| <a name="module_cognos_app_ec2"></a> [cognos\_app\_ec2](#module\_cognos\_app\_ec2) | terraform-aws-modules/ec2-instance/aws | 2.19.0 |
| <a name="module_cognos_db_ec2"></a> [cognos\_db\_ec2](#module\_cognos\_db\_ec2) | terraform-aws-modules/ec2-instance/aws | 2.19.0 |
| <a name="module_cognos_profile_app"></a> [cognos\_profile\_app](#module\_cognos\_profile\_app) | git@github.com:companieshouse/terraform-modules//aws/instance_profile?ref=tags/1.0.59 |  |
| <a name="module_cognos_profile_db"></a> [cognos\_profile\_db](#module\_cognos\_profile\_db) | git@github.com:companieshouse/terraform-modules//aws/instance_profile?ref=tags/1.0.59 |  |
| <a name="module_db_ec2_security_group"></a> [db\_ec2\_security\_group](#module\_db\_ec2\_security\_group) | terraform-aws-modules/security-group/aws | ~> 3.0 |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.cognos_app](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_group.cognos_db](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_key_pair.cognos_keypair](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) | resource |
| [aws_route53_record.cognos_app_ec2_internal](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.cognos_db_ec2_internal](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_kms_key.ebs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/kms_key) | data source |
| [aws_route53_zone.private_zone](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |
| [aws_security_group.nagios_shared](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/security_group) | data source |
| [aws_subnet_ids.application](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet_ids) | data source |
| [aws_subnet_ids.data](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet_ids) | data source |
| [aws_vpc.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |
| [vault_generic_secret.cognos_ec2_data](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/data-sources/generic_secret) | data source |
| [vault_generic_secret.internal_cidrs](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/data-sources/generic_secret) | data source |
| [vault_generic_secret.kms_keys](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/data-sources/generic_secret) | data source |
| [vault_generic_secret.security_kms_keys](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/data-sources/generic_secret) | data source |
| [vault_generic_secret.security_s3_buckets](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/data-sources/generic_secret) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ServiceTeam"></a> [ServiceTeam](#input\_ServiceTeam) | The service team that supports the Cognos application | `string` | `"Finance-Support"` | no |
| <a name="input_account"></a> [account](#input\_account) | Short version of the name of the AWS Account in which resources will be administered | `string` | n/a | yes |
| <a name="input_additional_cidr_ranges"></a> [additional\_cidr\_ranges](#input\_additional\_cidr\_ranges) | Security group for additional cidr blocks to allow Cognos third party access | `list(any)` | `[]` | no |
| <a name="input_app_ami"></a> [app\_ami](#input\_app\_ami) | ID of the AMI to use for application server | `string` | n/a | yes |
| <a name="input_app_cw_logs"></a> [app\_cw\_logs](#input\_app\_cw\_logs) | Map of log file information; used to create log groups, IAM permissions and passed to the application to configure remote logging | `map(any)` | `{}` | no |
| <a name="input_app_default_log_group_retention_in_days"></a> [app\_default\_log\_group\_retention\_in\_days](#input\_app\_default\_log\_group\_retention\_in\_days) | Total days to retain logs in CloudWatch log group if not specified for specific logs | `number` | `14` | no |
| <a name="input_app_ec2_count"></a> [app\_ec2\_count](#input\_app\_ec2\_count) | Name to be used on all resources as prefix | `string` | n/a | yes |
| <a name="input_app_ec2_name"></a> [app\_ec2\_name](#input\_app\_ec2\_name) | Name to be used on all resources as prefix | `string` | n/a | yes |
| <a name="input_app_instance_size"></a> [app\_instance\_size](#input\_app\_instance\_size) | The size of the application EC2 instance | `string` | n/a | yes |
| <a name="input_app_private_ip"></a> [app\_private\_ip](#input\_app\_private\_ip) | Private IP address to associate with the app instance | `string` | n/a | yes |
| <a name="input_application"></a> [application](#input\_application) | The name of the application | `string` | n/a | yes |
| <a name="input_aws_account"></a> [aws\_account](#input\_aws\_account) | The name of the AWS Account in which resources will be administered | `string` | n/a | yes |
| <a name="input_aws_profile"></a> [aws\_profile](#input\_aws\_profile) | The AWS profile to use | `string` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The AWS region in which resources will be administered | `string` | n/a | yes |
| <a name="input_db_ami"></a> [db\_ami](#input\_db\_ami) | ID of the AMI to use for DB server | `string` | n/a | yes |
| <a name="input_db_cw_logs"></a> [db\_cw\_logs](#input\_db\_cw\_logs) | Map of log file information; used to create log groups, IAM permissions and passed to the application to configure remote logging | `map(any)` | `{}` | no |
| <a name="input_db_default_log_group_retention_in_days"></a> [db\_default\_log\_group\_retention\_in\_days](#input\_db\_default\_log\_group\_retention\_in\_days) | Total days to retain logs in CloudWatch log group if not specified for specific logs | `number` | `14` | no |
| <a name="input_db_ec2_count"></a> [db\_ec2\_count](#input\_db\_ec2\_count) | Name to be used on all resources as prefix | `string` | n/a | yes |
| <a name="input_db_ec2_name"></a> [db\_ec2\_name](#input\_db\_ec2\_name) | Name to be used on all resources as prefix | `string` | n/a | yes |
| <a name="input_db_instance_size"></a> [db\_instance\_size](#input\_db\_instance\_size) | The size of the DB ec2 instance | `string` | n/a | yes |
| <a name="input_db_private_ip"></a> [db\_private\_ip](#input\_db\_private\_ip) | Private IP address to associate with the db instance | `string` | n/a | yes |
| <a name="input_delete_on_termination"></a> [delete\_on\_termination](#input\_delete\_on\_termination) | EBS delete on termination | `string` | `"false"` | no |
| <a name="input_ebs_encrypted"></a> [ebs\_encrypted](#input\_ebs\_encrypted) | EBS encrypted | `string` | `"true"` | no |
| <a name="input_ebs_optimized"></a> [ebs\_optimized](#input\_ebs\_optimized) | If true, the launched EC2 instance will be EBS-optimized | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The name of the environment | `string` | n/a | yes |
| <a name="input_get_password_data"></a> [get\_password\_data](#input\_get\_password\_data) | If true, wait for password data to become available and retrieve it. | `bool` | `false` | no |
| <a name="input_monitoring"></a> [monitoring](#input\_monitoring) | If true, the launched EC2 instance will have detailed monitoring enabled | `bool` | `false` | no |
| <a name="input_region"></a> [region](#input\_region) | Short version of the name of the AWS region in which resources will be administered | `string` | n/a | yes |
| <a name="input_vault_password"></a> [vault\_password](#input\_vault\_password) | Password for connecting to Vault - usually supplied through TF\_VARS | `string` | n/a | yes |
| <a name="input_vault_username"></a> [vault\_username](#input\_vault\_username) | Username for connecting to Vault - usually supplied through TF\_VARS | `string` | n/a | yes |
| <a name="input_volume_type"></a> [volume\_type](#input\_volume\_type) | EBS volume type | `string` | `"gp3"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cognos_app_ec2_address_internal"></a> [cognos\_app\_ec2\_address\_internal](#output\_cognos\_app\_ec2\_address\_internal) | n/a |
| <a name="output_cognos_db_ec2_address_internal"></a> [cognos\_db\_ec2\_address\_internal](#output\_cognos\_db\_ec2\_address\_internal) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->