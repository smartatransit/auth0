resource "auth0_hook" "internal" {
  name = "client-credential-exchange"
  script = templatefile("js/credentials-exchange.js", {
    anonymous_client_id = auth0_client.anonymous.client_id
    rules_client_id     = auth0_client.rules.client_id
  })

  trigger_id = "credentials-exchange"
  enabled    = true
}
