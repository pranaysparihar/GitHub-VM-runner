output "vm_ids" {
  value = azurerm_virtual_machine.vm[*].id
}

output "vm_ips" {
  value = azurerm_network_interface.nic[*].private_ip_address
}