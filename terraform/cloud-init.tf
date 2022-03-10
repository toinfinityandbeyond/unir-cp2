


data "template_cloudinit_config" "config" {
  gzip          = true
  base64_encode = true

  # Main cloud-config configuration file.
  part {
    content_type = "text/cloud-config"
    # content = templatefile(
    #   "cloud-init.yaml",
    #   {
    #     publickey  = file(var.public_key_path)
    #     privatekey = file("~/.ssh/sshKey.pem")
    #     sshuser    = var.ssh_user
    # })
    content = yamlencode({
      "write_files" : [{
        "path" : "/home/${var.ssh_user}/.ssh/id_rsa",
        "content" : file(var.private_key_path),
        "owner" : "azureuser:azureuser",
        "permissions" : "0400",
        "defer" : true
        },
        {
          "path" : "/home/${var.ssh_user}/.ssh/id_rsa.pub",
          "content" : file(var.public_key_path),
          "owner" : "azureuser:azureuser",
          "permissions" : "0400",
          "defer" : true
      }],
      "package_update" : true,
      "packages" : ["ansible", "git"],
    })
  }
}