output "app_service_default_hostname" {
  description = "Hostname padrão do App Service."
  value       = azurerm_linux_web_app.service_plan.default_hostname
}
