resource "aws_acm_certificate" "acm_certificate" {
  private_key       = acme_certificate.certificate.private_key_pem
  certificate_body  = acme_certificate.certificate.certificate_pem
  certificate_chain = "${acme_certificate.certificate.certificate_pem}${acme_certificate.certificate.issuer_pem}"

  tags = {
    Name = "${var.env}-certificate"
    env  = var.env
  }

  # certificate_transparency_logging_preference gets 'DISABLED' value outside of Terraform scope after the creation of
  # an ACM certificate. When Let's Encrypt certificate is renewed, Terraform marks the ACM certificate to be replaced
  # as seen below:
  # - options {
  #     - certificate_transparency_logging_preference = "DISABLED" -> null # forces replacement
  #   }
  # To avoid the replacement of the ACM certificate, we tell Terraform to ignore modifications on 'options' block
  # see https://www.terraform.io/docs/providers/aws/r/acm_certificate.html#options-configuration-block
  # Note: Despite the certificate transparency logging being set to 'DISABLED' by AWS, the public
  # certificates are still being logged in the transparency logs (verified on certificate search service https://crt.sh/)
  # see https://docs.aws.amazon.com/acm/latest/userguide/acm-concepts.html#concept-transparency
  lifecycle {
    ignore_changes = [
      options,
    ]
  }
}
