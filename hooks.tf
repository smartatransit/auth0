# comma-separated lists of client_ids to map into different roles
resource "auth0_rule" "user" {
  name   = "ataper"
  script = file("js/user.js")

  enabled = true
}

resource "auth0_hook" "internal" {
  name = "InternalClient Credential Exchange Hook"
  script = templatefile("js/internal.js", {
    anonymous_client_id = auth0_client.anonymous.client_id
    rules_client_id     = auth0_client.rules.client_id
  })

  trigger_id = "credentials-exchange"
  enabled    = true
}
