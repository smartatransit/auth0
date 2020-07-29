variable "base_domain" {
  type = string
}
variable "auth0_domain" {
  type = string
}
variable "auth0_client_id" {
  type = string
}
variable "auth0_client_secret" {
  type = string
}

locals {
  services_domain = "services.${var.base_domain}"
  claims_domain   = "jwt.${var.claims_domain}"
}
