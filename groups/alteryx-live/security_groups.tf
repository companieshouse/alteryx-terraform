# ------------------------------------------------------------------------------
# NLB Security Group and rules
# ------------------------------------------------------------------------------

resource "aws_security_group" "ec2_nlb" {
  name        = "sgr-${var.application}-${var.application_environment}-server-nlb"
  description = "Security group for the ${var.application_environment} ${var.application} Server nlb"
  vpc_id      = data.aws_vpc.vpc.id
}

resource "aws_vpc_security_group_ingress_rule" "httpsnlb" {
  description       = "nlb Access"
  security_group_id = aws_security_group.ec2_nlb.id
  prefix_list_id    = data.aws_ec2_managed_prefix_list.admin.id
  ip_protocol       = "tcp"
  from_port         = 443
  to_port           = 443
}

resource "aws_vpc_security_group_egress_rule" "instancenlb" {
  description                  = "HTTP to instance"
  security_group_id            = aws_security_group.ec2_nlb.id
  referenced_security_group_id = aws_security_group.ec2_nlb.id
  ip_protocol                  = "tcp"
  from_port                    = 80
  to_port                      = 80
}
