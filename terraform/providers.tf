provider "aws" {
  version = "= 2.51.0"
  region  = var.region
}

provider "acme" {
  version    = "= 1.5.0"
  server_url = "https://acme-staging-v02.api.letsencrypt.org/directory"
}

provider "acme" {
  alias      = "production"
  version    = "= 1.5.0"
  server_url = "https://acme-v02.api.letsencrypt.org/directory"
}

provider "tls" {
  version = "= 2.1.1"
}
