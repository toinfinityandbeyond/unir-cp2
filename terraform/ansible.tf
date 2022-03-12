# Update Ansible inventory
resource "local_file" "ansible_host" {
  depends_on = [
    azurerm_linux_virtual_machine.myterraformvm[0],
    azurerm_linux_virtual_machine.myterraformvm[1],
    azurerm_linux_virtual_machine.myterraformvm[2],
    azurerm_linux_virtual_machine.myterraformvm[3],
  ]
  content  = "[all:vars]\nansible_python_interpreter=/usr/bin/python3\nansible_user=${var.ssh_user}\nansible_ssh_common_args='-o StrictHostKeyChecking=no'\n\n[master]\n${azurerm_linux_virtual_machine.myterraformvm[0].public_ip_address}\n\n[workers]\n${azurerm_linux_virtual_machine.myterraformvm[1].public_ip_address}\n${azurerm_linux_virtual_machine.myterraformvm[2].public_ip_address}\n\n[nfs]\n${azurerm_linux_virtual_machine.myterraformvm[3].public_ip_address}"
  filename = "../ansible/inventory"
}

# Generate group_var for public ips
resource "local_file" "public_ips" {
  depends_on = [
    azurerm_linux_virtual_machine.myterraformvm[0],
    azurerm_linux_virtual_machine.myterraformvm[1],
    azurerm_linux_virtual_machine.myterraformvm[2],
    azurerm_linux_virtual_machine.myterraformvm[3],
  ]
  content  = "---\nmaster_public_ip:${azurerm_linux_virtual_machine.myterraformvm[0].public_ip_address}\nworker1_public_ip:${azurerm_linux_virtual_machine.myterraformvm[1].public_ip_address}\nworker2_public_ip:${azurerm_linux_virtual_machine.myterraformvm[2].public_ip_address}\nnfs_public_ip:${azurerm_linux_virtual_machine.myterraformvm[3].public_ip_address}"
  filename = "../ansible/group_vars/public_ips"
}

# Upload Ansible playbook 
resource "null_resource" "null1" {
  depends_on = [
    local_file.ansible_host,
    local_file.public_ips
  ]

  # waits vm to setup
  provisioner "local-exec" {
    command = "sleep 30"
  }
  # uploads all content from ansible folder to master
  provisioner "local-exec" {
    command = "scp -r -o StrictHostKeyChecking=no -i ${var.private_key_path} ../ansible ${var.ssh_user}@${azurerm_linux_virtual_machine.myterraformvm[0].public_ip_address}:/home/${var.ssh_user}"
  }

}

# Run Ansible playbook
resource "null_resource" "null2" {
  depends_on = [
    null_resource.null1
  ]

  # waits to install all dependencies and packages through cloud-init
  provisioner "local-exec" {
    command = "sleep 120"
  }

  # check connectivity with ansible
  provisioner "local-exec" {
    command = "ssh -o StrictHostKeyChecking=no -i ${var.private_key_path} ${var.ssh_user}@${azurerm_linux_virtual_machine.myterraformvm[0].public_ip_address} 'ansible -i ansible/inventory -m ping all'"
  }

}