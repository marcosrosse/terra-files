output "web_application_firewall_id" {
  description = "ID do Azure Web Application Firewall (WAF)."
  value       = azurerm_application_gateway.application_gateway.id
}
