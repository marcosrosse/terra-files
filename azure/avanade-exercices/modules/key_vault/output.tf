output "key_vault_id" {
  description = "ID do Azure Key Vault."
  value       = azurerm_key_vault.key_vault.id
}
