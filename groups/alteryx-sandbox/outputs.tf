output "alteryx_server_ec2_address_internal" {
  value = [for entry in aws_route53_record.alteryx_server : entry.fqdn]
}

output "alteryx_worker_ec2_address_internal" {
  value = [for entry in aws_route53_record.alteryx_worker : entry.fqdn]
}
