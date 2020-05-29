resource "aws_acm_certificate" "acm_certificate" {
  private_key       = acme_certificate.certificate.private_key_pem
  certificate_body  = acme_certificate.certificate.certificate_pem
  certificate_chain = "${acme_certificate.certificate.certificate_pem}${acme_certificate.certificate.issuer_pem}"

  tags = {
    Name = "${var.env}-certificate"
    env  = var.env
  }
}
