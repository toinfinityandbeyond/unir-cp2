# Print master, workers and nfs node IP
output "master" { value = azurerm_linux_virtual_machine.myterraformvm[0].public_ip_address }
output "worker01" { value = azurerm_linux_virtual_machine.myterraformvm[1].public_ip_address }
output "worker02" { value = azurerm_linux_virtual_machine.myterraformvm[2].public_ip_address }
output "nfs" { value = azurerm_linux_virtual_machine.myterraformvm[3].public_ip_address }
