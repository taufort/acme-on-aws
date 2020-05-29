resource "acme_certificate" "certificate" {
  account_key_pem           = var.account_key_pem
  common_name               = var.common_name
  subject_alternative_names = var.subject_alternative_names
  recursive_nameservers     = var.recursive_nameservers

  dns_challenge {
    provider = "route53"

    config = {
      AWS_HOSTED_ZONE_ID = var.route53_public_zone_id
    }
  }
}
