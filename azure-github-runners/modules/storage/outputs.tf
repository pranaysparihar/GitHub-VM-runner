output "storage_account_key" {
  value = azurerm_storage_account.runner_storage.primary_access_key
  sensitive = true
}

output "storage_account_name" {
  value = azurerm_storage_account.runner_storage.name
}

output "storage_container_name" {
  value = azurerm_storage_container.scripts.name
}

output "runner_script_url" {
  value = azurerm_storage_blob.runner_script.url
}