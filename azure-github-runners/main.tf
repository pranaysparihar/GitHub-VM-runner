provider "azurerm" {
  features {}
}

locals {
  resource_group_name = "${var.project_name}-${var.environment}-rg"
  tags = {
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "Terraform"
  }
}

resource "azurerm_resource_group" "rg" {
  name     = local.resource_group_name
  location = var.location
  tags     = local.tags
}

module "network" {
  source              = "./modules/network"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  vnet_address_space  = var.vnet_address_space
  subnet_prefix       = var.subnet_prefix
  tags                = local.tags
}

module "storage" {
  source              = "./modules/storage"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  tags                = local.tags
  github_token        = var.github_token
  github_repo_url     = var.github_repo_url
}

module "compute" {
  source              = "./modules/compute"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  subnet_id           = module.network.subnet_id
  runner_count        = var.runner_count
  vm_size             = var.vm_size
  admin_username      = var.admin_username
  github_token        = var.github_token
  github_repo_url     = var.github_repo_url
}