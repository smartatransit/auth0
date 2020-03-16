resource "auth0_rule_config" "client_id" {
  key   = "client_id"
  value = auth0_client.auth0.client_id
}
resource "auth0_rule_config" "client_secret" {
  key   = "client_secret"
  value = auth0_client.auth0.client_secret
}
resource "auth0_rule_config" "audience" {
  key   = "audience"
  value = "https://api-gateway.services.ataper.net" # TODO parametrize
}

resource "auth0_rule" "internal_claims" {
  name    = "ataper"
  script  = file("rule.js")
  enabled = true
}
