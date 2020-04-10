output "api_url" {
  value = "https://${var.auth0_domain}"
}
output "audience" {
  value = local.ataper_audience
}
output "anonymous_client" {
  value = auth0_client.anonymous
}
