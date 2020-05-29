locals {
  dev_tls_keys_secret = {
    private_key = module.dev_certificate.private_key_pem
  }
  dev_tls_certificates_secret = {
    cert        = module.dev_certificate.certificate_pem
    issuer_cert = module.dev_certificate.issuer_pem
    chain_cert  = module.dev_certificate.chain_pem
  }
}

resource "aws_secretsmanager_secret" "dev_tls_private_keys_secret" {
  name                    = "${var.applicative_env}/production/tls/private_keys"
  description             = "${var.applicative_env} environment Production TLS private keys"
  recovery_window_in_days = var.secret_recovery_window_in_days

  tags = {
    env  = var.applicative_env
    role = "tls"
    type = "production"
  }
}

resource "aws_secretsmanager_secret_version" "dev_tls_private_keys_secret_version" {
  secret_id     = aws_secretsmanager_secret.dev_tls_private_keys_secret.id
  secret_string = jsonencode(local.dev_tls_keys_secret)
}

resource "aws_secretsmanager_secret" "dev_tls_certificates_secret" {
  name                    = "${var.applicative_env}/production/tls/certificates"
  description             = "${var.applicative_env} environment Production TLS certificates"
  recovery_window_in_days = var.secret_recovery_window_in_days

  tags = {
    env  = var.applicative_env
    role = "tls"
    type = "production"
  }
}

resource "aws_secretsmanager_secret_version" "dev_tls_certificates_secret_version" {
  secret_id     = aws_secretsmanager_secret.dev_tls_certificates_secret.id
  secret_string = jsonencode(local.dev_tls_certificates_secret)
}
