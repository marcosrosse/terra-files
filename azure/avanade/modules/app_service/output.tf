output "app_service_default_hostname" {
  description = "App Service default hostname."
  value       = azurerm_linux_web_app.app.default_hostname
}
output "frontDoorEndpointHostName" {
  value = azurerm_cdn_frontdoor_endpoint.endpoint.host_name
}