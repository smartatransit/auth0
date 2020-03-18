####################################################################
# auth0.tf
####################################################################
#
# This file contains configuration for:
# (1) the auth0 provider
# (2) Ataper's tenant-level auth0 configuration
# (3) access to the auth0 management API, including the access used
#     by this terraform workspace
#
####################################################################

provider "auth0" {
  domain        = var.auth0_domain
  client_id     = var.auth0_client_id
  client_secret = var.auth0_client_secret
}

resource "auth0_tenant" "auth0" {
  friendly_name    = "Ataper Transit"
  default_audience = local.ataper_audience

  allowed_logout_urls   = []
  enabled_locales       = ["en"]
  sandbox_version       = "8"
  idle_session_lifetime = 0
  session_lifetime      = 0

  flags {}
}

resource "auth0_resource_server" "management_api" {
  name        = "Auth0 Management API"
  identifier  = "https://${var.auth0_domain}/api/v2/"
  signing_alg = "RS256"

  lifecycle {
    ignore_changes = [scopes]
  }
}

resource "auth0_client" "terraform" {
  name            = "Terraform"
  description     = "Used by Terraform rules to access the Auth0 Management API"
  app_type        = "non_interactive"
  oidc_conformant = true

  jwt_configuration {
    lifetime_in_seconds = 300
  }
}

resource "auth0_client_grant" "terraform" {
  client_id = auth0_client.terraform.id
  audience  = auth0_resource_server.management_api.identifier
  scope     = local.management_api_scopes
}

locals {
  management_api_scopes = [
    "blacklist:tokens",
    "create:custom_domains",
    "create:client_grants",
    "create:client_keys",
    "create:clients",
    "create:connections",
    "create:device_credentials",
    "create:email_provider",
    "create:hooks",
    "create:resource_servers",
    "create:rules",
    "create:shields",
    "create:user_tickets",
    "create:users_app_metadata",
    "create:users",
    "create:email_templates",
    "create:guardian_enrollment_tickets",
    "create:log_streams",
    "create:passwords_checking_job",
    "create:roles",
    "create:signing_keys",
    "delete:anomaly_blocks",
    "delete:client_grants",
    "delete:client_keys",
    "delete:clients",
    "delete:connections",
    "delete:device_credentials",
    "delete:email_provider",
    "delete:guardian_enrollments",
    "delete:hooks",
    "delete:resource_servers",
    "delete:rules_configs",
    "delete:rules",
    "delete:shields",
    "delete:grants",
    "delete:users_app_metadata",
    "delete:users",
    "delete:custom_domains",
    "delete:log_streams",
    "delete:roles",
    "delete:passwords_checking_job",
    "read:anomaly_blocks",
    "read:client_grants",
    "read:client_keys",
    "read:clients",
    "read:connections",
    "read:device_credentials",
    "read:email_provider",
    "read:guardian_enrollments",
    "read:guardian_factors",
    "read:hooks",
    "read:logs",
    "read:mfa_policies",
    "read:resource_servers",
    "read:rules_configs",
    "read:rules",
    "read:shields",
    "read:stats",
    "read:tenant_settings",
    "read:triggers",
    "read:grants",
    "read:users_app_metadata",
    "read:user_idp_tokens",
    "read:users",
    "read:branding",
    "read:custom_domains",
    "read:email_templates",
    "read:log_streams",
    "read:prompts",
    "read:roles",
    "read:signing_keys",
    "update:client_grants",
    "update:client_keys",
    "update:clients",
    "update:connections",
    "update:device_credentials",
    "update:email_provider",
    "update:guardian_factors",
    "update:hooks",
    "update:mfa_policies",
    "update:resource_servers",
    "update:rules_configs",
    "update:rules",
    "update:tenant_settings",
    "update:triggers",
    "update:users_app_metadata",
    "update:users",
    "update:branding",
    "update:email_templates",
    "update:log_streams",
    "update:prompts",
    "update:roles",
    "update:signing_keys",
  ]
}
