resource "azurerm_network_interface" "nic" {
  count               = var.runner_count
  name                = "github-runner-nic-${count.index}"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "vm" {
  count                = var.runner_count
  name                 = "github-runner-vm-${count.index}"
  location            = var.location
  resource_group_name = var.resource_group_name
  vm_size            = var.vm_size

  network_interface_ids = [azurerm_network_interface.nic[count.index].id]

  os_profile {
    computer_name  = "runner-${count.index}"
    admin_username = var.admin_username
    custom_data    = base64encode(templatefile("${path.module}/../../scripts/configure-runner.sh", {
      GITHUB_TOKEN = var.github_token
      GITHUB_REPO_URL = var.github_repo_url
      RUNNER_VERSION = "2.303.0"
      HOSTNAME = "runner-${count.index}"
    }))
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path     = "/home/${var.admin_username}/.ssh/authorized_keys"
      key_data = file("~/.ssh/id_rsa.pub")
    }
  }

  storage_os_disk {
    name              = "runner-disk-${count.index}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}
