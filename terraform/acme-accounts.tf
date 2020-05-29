resource "tls_private_key" "staging_account_private_key" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}

resource "acme_registration" "staging_account_registration" {
  account_key_pem = tls_private_key.staging_account_private_key.private_key_pem
  email_address   = var.acme_email
}

resource "tls_private_key" "production_account_private_key" {
  algorithm = "RSA"
  rsa_bits  = "4096"

  lifecycle {
    prevent_destroy = true
  }
}

resource "acme_registration" "production_account_registration" {
  provider        = acme.production
  account_key_pem = tls_private_key.production_account_private_key.private_key_pem
  email_address   = var.acme_email

  lifecycle {
    prevent_destroy = true
  }
}
