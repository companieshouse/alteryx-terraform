resource "aws_lb" "alteryx_live" {
  name               = "nlb-${var.application}-${var.application_environment}"
  internal           = true
  load_balancer_type = "network"
  security_groups    = [aws_security_group.ec2_nlb.id]
  subnets            = local.alteryx_subnet_id

  tags = {
    Environment = var.environment
    Service     = var.application
  }
}

resource "aws_lb_target_group" "alteryx_live_web" {
  name        = "${var.application}-${var.application_environment}-web"
  port        = 80
  protocol    = "TCP"
  target_type = "ip"
  vpc_id      = data.aws_vpc.vpc.id

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = "5"
    path                = "/gallery/api/status/ping/"
    protocol            = "HTTP"
    interval            = 30
    matcher             = "200"
  }
}

resource "aws_lb_target_group_attachment" "alteryx_live_web" {
  target_group_arn = aws_lb_target_group.alteryx_live_web.arn
  target_id        = module.alteryx_server_ec2[0].private_ip[0]
  port             = 80
}

resource "aws_acm_certificate" "certificate" {
  count = local.create_ssl_certificate ? 1 : 0

  domain_name               = "${var.application}.${var.environment}.${local.dns_zone_name}"
  subject_alternative_names = ["*.${var.application}.${var.environment}.${local.dns_zone_name}"]
  validation_method         = "DNS"
}

resource "aws_route53_record" "certificate_validation" {
  for_each = local.create_ssl_certificate ? {
    for dvo in aws_acm_certificate.certificate[0].domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      record = dvo.resource_record_value
    }
  } : {}

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = local.dns_zone_id
}

resource "aws_acm_certificate_validation" "certificate" {
  count = local.create_ssl_certificate ? 1 : 0

  certificate_arn         = aws_acm_certificate.certificate[0].arn
  validation_record_fqdns = [for record in aws_route53_record.certificate_validation : record.fqdn]
}

resource "aws_lb_listener" "alteryx_live_listener_443" {
  load_balancer_arn = aws_lb.alteryx_live.arn
  port              = "443"
  protocol          = "TLS"
  certificate_arn   = local.ssl_certificate_arn
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alteryx_live_web.arn
  }
}
