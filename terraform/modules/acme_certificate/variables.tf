variable "account_key_pem" {
  description = "The private key used to identity the account"
  type        = string
}

variable "common_name" {
  type = string
}

variable "env" {
  description = "Environment name"
  type        = string
}

variable "subject_alternative_names" {
  type    = list(string)
  default = []
}

variable "email_address" {
  description = "The contact email address for the account"
}

variable "route53_public_zone_id" {
  type = string
}

variable "recursive_nameservers" {
  description = "The recursive nameservers that will be used to check for propagation of the challenge record. Defaults to your system-configured DNS resolvers."
  type        = list(string)
  default     = []
}
