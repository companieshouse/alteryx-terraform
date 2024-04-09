# Load Balancer
resource "aws_lb" "alteryx_sandbox" {
  name               = "${var.environment}-${var.service}"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [module.alteryx_server_ec2_security_group.this_security_group_id]
  subnets            = var.application_subnets[*]
  tags = {
    Environment = var.environment
    Service     = var.service
  }
}

# Target configuration for HTTP / port 80
resource "aws_lb_target_group" "alteryx_sandbox_web" {
  name        = "${var.application}-${var.application_environment}-web"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = data.aws_vpc.vpc.id
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = "5"
    path                = "/"
    protocol            = "HTTP"
    interval            = 30
    matcher             = "200-399"
  }
}

resource "aws_lb_target_group_attachment" "alteryx_sandbox_web" {
  count            = var.alteryx_server_instance_count
  target_group_arn = aws_lb_target_group.alteryx_sandbox_web.arn
  target_id        = var.alteryx_server_private_ip
  port             = 80
}

# Configuration for Certificate
resource "aws_acm_certificate" "certificate" {
  count = local.create_ssl_certificate ? 1 : 0

  domain_name               = "${var.service}.${var.environment}.${local.dns_zone_name}"
  subject_alternative_names = ["*.${var.service}.${var.environment}.${local.dns_zone_name}"]
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

# Listener configuration
resource "aws_lb_listener" "alteryx_sandbox_listener_443" {
  load_balancer_arn = aws_lb.alteryx_sandbox.arn
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = local.ssl_certificate_arn
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alteryx_sandbox_web.arn
  }
}

# Create a listener resource to redirect HTTP to HTTPS
resource "aws_lb_listener" "alteryx_sandbox_listener_80_redirect" {
  load_balancer_arn = aws_lb.alteryx_sandbox.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}
