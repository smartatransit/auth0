# comma-separated lists of client_ids to map into different roles
resource "auth0_rule_config" "internal_client_ids" {
  key   = "rulesClientIDs"
  value = auth0_client.auth0.client_id
}
resource "auth0_rule_config" "anonymous_client_ids" {
  key   = "anonymousClientIDs"
  value = auth0_client.anonymous.client_id
}
resource "auth0_rule_config" "user_client_ids" {
  key   = "userClientIDs"
  value = auth0_client.native.client_id
}

resource "auth0_rule" "internal_claims" {
  name    = "ataper"
  script  = file("rule.js")
  enabled = true
}
