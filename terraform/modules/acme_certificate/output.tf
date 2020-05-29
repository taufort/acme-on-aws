output "private_key_pem" {
  value = acme_certificate.certificate.private_key_pem
}

output "certificate_pem" {
  value = acme_certificate.certificate.certificate_pem
}

output "issuer_pem" {
  value = acme_certificate.certificate.issuer_pem
}

output "chain_pem" {
  value = "${acme_certificate.certificate.certificate_pem}${acme_certificate.certificate.issuer_pem}"
}

output "certificate_arn" {
  value = aws_acm_certificate.acm_certificate.arn
}
