output "anonymous_client" {
  value = auth0_client.anonymous
}
output "ataper_api_public_keys_uri" {
  value = "https://${var.auth0_domain}/.well-known/jwks.json"
}
