source "azure-arm" {
  client_id                   = var.client_id
  client_secret               = var.client_secret
  subscription_id             = var.subscription_id
  tenant_id                   = var.tenant_id
  managed_image_name          = "github-runner-image"
  managed_image_resource_group_name = var.resource_group_name
  os_type                    = "Linux"
  image_publisher            = "Canonical"
  image_offer                = "UbuntuServer"
  image_sku                  = "18.04-LTS"
  location                   = var.location
  vm_size                    = "Standard_DS1_v2"
}

build {
  sources = ["source.azure-arm"]

  provisioner "shell" {
    script = "./scripts/setup.sh"
  }
}