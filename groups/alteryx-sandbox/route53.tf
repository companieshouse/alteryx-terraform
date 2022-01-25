resource "aws_route53_record" "alteryx_server" {
  count = var.alteryx_server_instance_count

  zone_id = data.aws_route53_zone.private_zone.zone_id
  name    = format("${var.application}-${var.application_environment}-server-%02s", count.index + 1)
  type    = "A"
  ttl     = "300"
  records = module.alteryx_server_ec2[count.index].private_ip
}

# resource "aws_route53_record" "alteryx_worker" {
#   count = var.alteryx_worker_instance_count

#   zone_id = data.aws_route53_zone.private_zone.zone_id
#   name    = format("${var.application}-${var.application_environment}-worker-%02s", count.index + 1)
#   type    = "A"
#   ttl     = "300"
#   records = module.alteryx_worker_ec2[count.index].private_ip
# }