# ------------------------------------------------------------------------------
# Applicatoin Security Group and rules
# ------------------------------------------------------------------------------
resource "aws_security_group" "alteryx_server_ec2_security_group2" {
  name        = "sgr-${var.application}-${var.application_environment}-server"
  description = "Security group for the ${var.application_environment} ${var.application} Server EC2"
  vpc_id      = data.aws_vpc.vpc.id
}

resource "aws_vpc_security_group_ingress_rule" "wmiadmin" {
  # for_each = local.azure_cidrs

  description       = "WMI Access"
  security_group_id = aws_security_group.alteryx_server_ec2_security_group2.id
  prefix_list_id    = data.aws_ec2_managed_prefix_list.admin.id
  ip_protocol       = "tcp"
  from_port         = 135
  to_port           = 135
}

resource "aws_vpc_security_group_ingress_rule" "wmici" {
  # for_each = local.azure_cidrs

  description       = "WMI Access"
  security_group_id = aws_security_group.alteryx_server_ec2_security_group2.id
  prefix_list_id    = data.aws_ec2_managed_prefix_list.ci.id
  ip_protocol       = "tcp"
  from_port         = 135
  to_port           = 135
}

resource "aws_vpc_security_group_ingress_rule" "ansible2" {

  description       = "Ansible Access"
  security_group_id = aws_security_group.alteryx_server_ec2_security_group2.id
  prefix_list_id    = data.aws_ec2_managed_prefix_list.ci.id
  ip_protocol       = "tcp"
  from_port         = 5986
  to_port           = 5986
}

resource "aws_vpc_security_group_ingress_rule" "rdptcp2" {

  description       = "Remote Desktop"
  security_group_id = aws_security_group.alteryx_server_ec2_security_group2.id
  prefix_list_id    = data.aws_ec2_managed_prefix_list.admin.id
  ip_protocol       = "tcp"
  from_port         = 3389
  to_port           = 3389
}

resource "aws_vpc_security_group_ingress_rule" "rdpudp2" {

  description       = "Remote Desktop"
  security_group_id = aws_security_group.alteryx_server_ec2_security_group2.id
  prefix_list_id    = data.aws_ec2_managed_prefix_list.admin.id
  ip_protocol       = "udp"
  from_port         = 3389
  to_port           = 3389
}

resource "aws_vpc_security_group_ingress_rule" "http2" {

  description                  = "http Access"
  security_group_id            = aws_security_group.alteryx_server_ec2_security_group2.id
  referenced_security_group_id = aws_security_group.alteryx_server_alb.id
  ip_protocol                  = "tcp"
  from_port                    = 80
  to_port                      = 80
}

# ------------------------------------------------------------------------------
# ALB Security Group and rules
# ------------------------------------------------------------------------------

resource "aws_security_group" "alteryx_server_alb" {
  name        = "sgr-${var.application}-${var.application_environment}-server-alb"
  description = "Security group for the ${var.application_environment} ${var.application} Server ALB"
  vpc_id      = data.aws_vpc.vpc.id
}

resource "aws_vpc_security_group_ingress_rule" "httpsalb" {

  description       = "alb Access"
  security_group_id = aws_security_group.alteryx_server_alb.id
  prefix_list_id    = data.aws_ec2_managed_prefix_list.admin.id
  ip_protocol       = "tcp"
  from_port         = 443
  to_port           = 443
}
