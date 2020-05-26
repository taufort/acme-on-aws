variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-1"
}

variable "acme_email" {
  type    = string
  default = "somebody@acme-on-aws.com"
}

variable "domain_name" {
  type    = string
  default = "acme-on-aws.com"
}

variable "devfactory_env" {
  type    = string
  default = "devfactory"
}

variable "applicative_env" {
  type    = string
  default = "dev"
}

variable "secret_recovery_window_in_days" {
  type = number
  # For tests purposes only
  default = 0
}
