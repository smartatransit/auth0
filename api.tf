####################################################################
# api.tf
####################################################################
#
# This file contains Auth0 configuration for the SMARTA API Gateway.
# This includes the following Auth0 clients, which are essentially
# authentication scenarios for the API:
# (1) the native app, which can be issued tokens through a login flow
# (2) the API gateway, which obtains anonymous tokens for users by
#     providing its `client_secret` directly to the auth0 API
# (3) the auth0 rule, which obtains a token for modifying user details
#     by providing its `client_secret` directly to the auth0 API
#
####################################################################

resource "auth0_resource_server" "smarta_api" {
  name = "smarta-api"

  identifier = "https://api-gateway.${local.services_domain}/"

  signing_alg                                     = "HS256"
  skip_consent_for_verifiable_first_party_clients = true
  token_lifetime                                  = 86400
  token_lifetime_for_web                          = 7200

  scopes {
    value       = "auth0"
    description = "Manage SMARTA users"
  }
  scopes {
    value       = "user"
    description = "Access normal end-user APIs"
  }
}

locals {
  smarta_audience = "https://${local.services_domain}/"
}

resource "auth0_resource_server" "smarta_api_symmetric" {
  name = "smarta-api"

  identifier = local.smarta_audience

  signing_alg                                     = "RS256"
  skip_consent_for_verifiable_first_party_clients = true
  token_lifetime                                  = 86400
  token_lifetime_for_web                          = 7200

  scopes {
    value       = "be:anonymous"
    description = "Can obtain anonymous tokens"
  }
  scopes {
    value       = "be:user"
    description = "Can obtain end-user tokens"
  }
  scopes {
    value       = "be:internal"
    description = "Can obtain internal access tokens"
  }
}

/////////////////////////////
// / // token sources // / //
/////////////////////////////

// user logins
resource "auth0_client" "native" {
  name            = "SMARTA Native"
  app_type        = "native"
  oidc_conformant = true
}

resource "auth0_client_grant" "native" {
  client_id = auth0_client.native.id
  audience  = local.smarta_audience
  scope     = ["be:user"]
}

// api gateway
resource "auth0_client" "anonymous" {
  name            = "Anonymous"
  description     = "Used by the SMARTA API Gateway rules to issue anonymous tokens"
  app_type        = "non_interactive"
  oidc_conformant = true
}

resource "auth0_client_grant" "anonymous" {
  client_id = auth0_client.anonymous.id
  audience  = local.smarta_audience
  scope     = ["be:anonymous"]
}

// auth0 rules
resource "auth0_client" "rules" {
  name            = "Auth0 rules"
  description     = "Used by auth0 rules to access SMARTA APIs"
  app_type        = "non_interactive"
  oidc_conformant = true
}

resource "auth0_client_grant" "rules" {
  client_id = auth0_client.rules.id
  audience  = local.smarta_audience
  scope     = ["be:internal"]
}
