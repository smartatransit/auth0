####################################################################
# api.tf
####################################################################
#
# This file contains Auth0 configuration for the Ataper API Gateway.
# This includes the following Auth0 clients, which are essentially
# authentication scenarios for the API:
# (1) the native app, which can be issued tokens through a login flow
# (2) the API gateway, which obtains anonymous tokens for users by
#     providing its `client_secret` directly to the auth0 API
# (3) the auth0 rule, which obtains a token for modifying user details
#     by providing its `client_secret` directly to the auth0 API
#
####################################################################

resource "auth0_resource_server" "ataper_api" {
  name = "ataper-api"

  identifier = "https://api-gateway.${var.services_domain}/"

  signing_alg                                     = "HS256"
  skip_consent_for_verifiable_first_party_clients = true
  token_lifetime                                  = 86400
  token_lifetime_for_web                          = 7200

  scopes {
    value       = "auth0"
    description = "Manage Ataper users"
  }
  scopes {
    value       = "user"
    description = "Access normal end-user APIs"
  }
}

resource "auth0_resource_server" "ataper_api_symmetric" {
  name = "ataper-api"

  identifier = "https://api-gateway.${var.services_domain}/"

  signing_alg                                     = "RS256"
  skip_consent_for_verifiable_first_party_clients = true
  token_lifetime                                  = 86400
  token_lifetime_for_web                          = 7200

  scopes {
    value       = "auth0"
    description = "Manage Ataper users"
  }
  scopes {
    value       = "user"
    description = "Access normal end-user APIs"
  }
}

/////////////////////////////
// / // token sources // / //
/////////////////////////////

// user logins
resource "auth0_client" "native" {
  name            = "Ataper Native"
  app_type        = "native"
  oidc_conformant = true
}

resource "auth0_client_grant" "native" {
  client_id = auth0_client.native.id
  audience  = auth0_resource_server.ataper_api_symmetric.identifier
  scope     = ["user"]
}

// api gateway
resource "auth0_client" "anonymous" {
  name            = "Anonymous"
  description     = "Used by the Ataper API Gateway rules to issue anonymous tokens"
  app_type        = "non_interactive"
  oidc_conformant = true
}

resource "auth0_client_grant" "anonymous" {
  client_id = auth0_client.anonymous.id
  audience  = auth0_resource_server.ataper_api_symmetric.identifier
  scope     = []
}

// auth0 rules
resource "auth0_client" "auth0" {
  name            = "Auth0 rules"
  description     = "Used by auth0 rules to access Ataper APIs"
  app_type        = "non_interactive"
  oidc_conformant = true
}

resource "auth0_client_grant" "auth0" {
  client_id = auth0_client.auth0.id
  audience  = auth0_resource_server.ataper_api_symmetric.identifier
  scope     = ["auth0"]
}
