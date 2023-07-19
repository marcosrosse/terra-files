output "traffic_manager_dns_name" {
  description = "Nome DNS do Traffic Manager."
  value       = azurerm_traffic_manager_profile.traffic_manager.dns_config.fqdn
}
