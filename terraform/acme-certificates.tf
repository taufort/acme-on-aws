module "devfactory_certificate" {
  source = "./modules/acme_certificate"

  account_key_pem = acme_registration.staging_account_registration.account_key_pem
  common_name     = "gitlab.${var.domain_name}"
  subject_alternative_names = [
    "sonarqube.${var.domain_name}"
  ]
  env                    = var.devfactory_env
  email_address          = var.acme_email
  route53_public_zone_id = aws_route53_zone.main_public_route53_zone.zone_id
  recursive_nameservers = [
    "${aws_route53_zone.main_public_route53_zone.name_servers.0}:53",
    "${aws_route53_zone.main_public_route53_zone.name_servers.1}:53",
    "${aws_route53_zone.main_public_route53_zone.name_servers.2}:53",
    "${aws_route53_zone.main_public_route53_zone.name_servers.3}:53",
  ]
}

module "dev_certificate" {
  source = "./modules/acme_certificate"

  account_key_pem        = acme_registration.production_account_registration.account_key_pem
  common_name            = "*.${local.dev_fqdn}"
  env                    = var.applicative_env
  email_address          = var.acme_email
  route53_public_zone_id = aws_route53_zone.dev_public_env_zone.zone_id
  recursive_nameservers = [
    "${aws_route53_zone.dev_public_env_zone.name_servers.0}:53",
    "${aws_route53_zone.dev_public_env_zone.name_servers.1}:53",
    "${aws_route53_zone.dev_public_env_zone.name_servers.2}:53",
    "${aws_route53_zone.dev_public_env_zone.name_servers.3}:53",
  ]

  providers = {
    acme = acme.production
  }
}
