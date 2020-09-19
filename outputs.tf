output "api_url" {
  value = "https://${var.auth0_domain}"
}
output "audience" {
  value = local.smarta_audience
}
output "anonymous_client" {
  value = auth0_client.anonymous
}
output "developer_access_key" {
  value = "${auth0_client.developer.id}|${auth0_client.developer.client_secret}"
}
