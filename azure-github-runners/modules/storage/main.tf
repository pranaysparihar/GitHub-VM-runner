resource "azurerm_storage_account" "runner_storage" {
  name                     = "runner${random_id.suffix.hex}"
  resource_group_name      = var.resource_group_name
  location                = var.location
  account_tier            = "Standard"
  account_replication_type = "LRS"
  tags                    = var.tags
}

resource "random_id" "suffix" {
  byte_length = 4
}

resource "azurerm_storage_container" "scripts" {
  name                  = "runner-scripts"
  storage_account_name  = azurerm_storage_account.runner_storage.name
  container_access_type = "private"
}

resource "azurerm_storage_blob" "runner_script" {
  name                   = "configure-runner.sh"
  storage_account_name   = azurerm_storage_account.runner_storage.name
  storage_container_name = azurerm_storage_container.scripts.name
  type                  = "Block"
  source_content        = file("${path.root}/scripts/configure-runner.sh")
}