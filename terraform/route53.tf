resource "aws_route53_zone" "main_public_route53_zone" {
  name    = "${var.domain_name}."
  comment = "Main internet public domain"

  lifecycle {
    prevent_destroy = true
  }
}

locals {
  dev_fqdn = "${var.applicative_env}.${var.domain_name}."
}

resource "aws_route53_zone" "dev_public_env_zone" {
  name    = local.dev_fqdn
  comment = "${var.applicative_env} public domain"

  tags = {
    Name = "${var.applicative_env}:public-route53-zone"
    env  = var.applicative_env
  }
}

# Delegating authority for 'dev.acme-on-aws.com' subdomain to the main
# public Route53 hosted zone
resource "aws_route53_record" "dev_subdomain_NS_record" {
  name    = local.dev_fqdn
  ttl     = 60
  type    = "NS"
  zone_id = aws_route53_zone.main_public_route53_zone.zone_id

  records = [
    aws_route53_zone.dev_public_env_zone.name_servers.0,
    aws_route53_zone.dev_public_env_zone.name_servers.1,
    aws_route53_zone.dev_public_env_zone.name_servers.2,
    aws_route53_zone.dev_public_env_zone.name_servers.3,
  ]
}
