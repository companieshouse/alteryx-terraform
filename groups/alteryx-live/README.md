# aws-alteryx-live-terraform

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
| <a name="module_alteryx_server_ec2"></a> [alteryx\_server\_ec2](#module\_alteryx\_server\_ec2) | terraform-aws-modules/ec2-instance/aws | 2.19.0 |
| <a name="module_alteryx_server_ec2_security_group"></a> [alteryx\_server\_ec2\_security\_group](#module\_alteryx\_server\_ec2\_security\_group) | terraform-aws-modules/security-group/aws | ~> 3.0 |
| <a name="module_alteryx_server_profile"></a> [alteryx\_server\_profile](#module\_alteryx\_server\_profile) | git@github.com:companieshouse/terraform-modules//aws/instance_profile?ref=tags/1.0.59 |  |
| <a name="module_alteryx_worker_ec2"></a> [alteryx\_worker\_ec2](#module\_alteryx\_worker\_ec2) | terraform-aws-modules/ec2-instance/aws | 2.19.0 |
| <a name="module_alteryx_worker_ec2_security_group"></a> [alteryx\_worker\_ec2\_security\_group](#module\_alteryx\_worker\_ec2\_security\_group) | terraform-aws-modules/security-group/aws | ~> 3.0 |
| <a name="module_alteryx_worker_profile"></a> [alteryx\_worker\_profile](#module\_alteryx\_worker\_profile) | git@github.com:companieshouse/terraform-modules//aws/instance_profile?ref=tags/1.0.59 |  |

## Resources

| Name | Type |
|------|------|
| [aws_key_pair.alteryx_keypair](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) | resource |
| [aws_route53_record.alteryx_server](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.alteryx_worker](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_acm_certificate.acm_cert](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/acm_certificate) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_kms_key.ebs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/kms_key) | data source |
| [aws_route53_zone.private_zone](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |
| [aws_subnet_ids.alteryx](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet_ids) | data source |
| [aws_vpc.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |
| [vault_generic_secret.alteryx_ec2_data](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/data-sources/generic_secret) | data source |
| [vault_generic_secret.internal_cidrs](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/data-sources/generic_secret) | data source |
| [vault_generic_secret.kms_keys](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/data-sources/generic_secret) | data source |
| [vault_generic_secret.security_kms_keys](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/data-sources/generic_secret) | data source |
| [vault_generic_secret.security_s3_buckets](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/data-sources/generic_secret) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account"></a> [account](#input\_account) | Short version of the name of the AWS Account in which resources will be administered | `string` | n/a | yes |
| <a name="input_alteryx_server_additional_storage_gb"></a> [alteryx\_server\_additional\_storage\_gb](#input\_alteryx\_server\_additional\_storage\_gb) | Total additional storage required on the EC2 instance | `string` | n/a | yes |
| <a name="input_alteryx_server_ami"></a> [alteryx\_server\_ami](#input\_alteryx\_server\_ami) | ID of the AMI to use for alteryxlication server | `string` | n/a | yes |
| <a name="input_alteryx_server_instance_count"></a> [alteryx\_server\_instance\_count](#input\_alteryx\_server\_instance\_count) | Name to be used on all resources as prefix | `string` | n/a | yes |
| <a name="input_alteryx_server_instance_type"></a> [alteryx\_server\_instance\_type](#input\_alteryx\_server\_instance\_type) | The size of the alteryxlication EC2 instance | `string` | n/a | yes |
| <a name="input_alteryx_server_private_ip"></a> [alteryx\_server\_private\_ip](#input\_alteryx\_server\_private\_ip) | Private IP address to associate with the alteryx instance | `string` | n/a | yes |
| <a name="input_alteryx_server_storage_gb"></a> [alteryx\_server\_storage\_gb](#input\_alteryx\_server\_storage\_gb) | Total default storage required on the EC2 instance | `string` | n/a | yes |
| <a name="input_alteryx_worker_ami"></a> [alteryx\_worker\_ami](#input\_alteryx\_worker\_ami) | ID of the AMI to use for alteryxlication worker | `string` | n/a | yes |
| <a name="input_alteryx_worker_instance_count"></a> [alteryx\_worker\_instance\_count](#input\_alteryx\_worker\_instance\_count) | Name to be used on all resources as prefix | `string` | n/a | yes |
| <a name="input_alteryx_worker_instance_type"></a> [alteryx\_worker\_instance\_type](#input\_alteryx\_worker\_instance\_type) | The size of the alteryxlication EC2 instance | `string` | n/a | yes |
| <a name="input_alteryx_worker_private_ip"></a> [alteryx\_worker\_private\_ip](#input\_alteryx\_worker\_private\_ip) | Private IP address to associate with the alteryx worker instance | `string` | n/a | yes |
| <a name="input_alteryx_worker_storage_gb"></a> [alteryx\_worker\_storage\_gb](#input\_alteryx\_worker\_storage\_gb) | Total default storage required on the EC2 instance | `string` | n/a | yes |
| <a name="input_application"></a> [application](#input\_application) | The name of the application | `string` | n/a | yes |
| <a name="input_application_environment"></a> [application\_environment](#input\_application\_environment) | The specific application environment e.g. alteryx-live | `string` | n/a | yes |
| <a name="input_aws_account"></a> [aws\_account](#input\_aws\_account) | The name of the AWS Account in which resources will be administered | `string` | n/a | yes |
| <a name="input_aws_profile"></a> [aws\_profile](#input\_aws\_profile) | The AWS profile to use | `string` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The AWS region in which resources will be administered | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The name of the environment | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Short version of the name of the AWS region in which resources will be administered | `string` | n/a | yes |
| <a name="input_vault_password"></a> [vault\_password](#input\_vault\_password) | Password for connecting to Vault - usually supplied through TF\_VARS | `string` | n/a | yes |
| <a name="input_vault_username"></a> [vault\_username](#input\_vault\_username) | Username for connecting to Vault - usually supplied through TF\_VARS | `string` | n/a | yes |
| <a name="input_alteryx_server_detailed_monitoring"></a> [alteryx\_server\_detailed\_monitoring](#input\_alteryx\_server\_detailed\_monitoring) | If true, the launched EC2 instance will have detailed monitoring enabled | `bool` | `false` | no |
| <a name="input_alteryx_server_get_password_data"></a> [alteryx\_server\_get\_password\_data](#input\_alteryx\_server\_get\_password\_data) | If true, wait for password data to become available and retrieve it. | `bool` | `false` | no |
| <a name="input_alteryx_worker_detailed_monitoring"></a> [alteryx\_worker\_detailed\_monitoring](#input\_alteryx\_worker\_detailed\_monitoring) | If true, the launched EC2 instance will have detailed monitoring enabled | `bool` | `false` | no |
| <a name="input_alteryx_worker_get_password_data"></a> [alteryx\_worker\_get\_password\_data](#input\_alteryx\_worker\_get\_password\_data) | If true, wait for password data to become available and retrieve it. | `bool` | `false` | no |
| <a name="input_delete_on_termination"></a> [delete\_on\_termination](#input\_delete\_on\_termination) | EBS delete on termination | `string` | `"false"` | no |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | The name of the environment | `string` | `"*.companieshouse.gov.uk"` | no |
| <a name="input_ebs_encrypted"></a> [ebs\_encrypted](#input\_ebs\_encrypted) | EBS encrypted | `string` | `"true"` | no |
| <a name="input_ebs_optimized"></a> [ebs\_optimized](#input\_ebs\_optimized) | If true, the launched EC2 instance will be EBS-optimized | `bool` | `true` | no |
| <a name="input_volume_type"></a> [volume\_type](#input\_volume\_type) | EBS volume type | `string` | `"gp3"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alteryx_server_ec2_address_internal"></a> [alteryx\_server\_ec2\_address\_internal](#output\_alteryx\_server\_ec2\_address\_internal) | n/a |
| <a name="output_alteryx_worker_ec2_address_internal"></a> [alteryx\_worker\_ec2\_address\_internal](#output\_alteryx\_worker\_ec2\_address\_internal) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->