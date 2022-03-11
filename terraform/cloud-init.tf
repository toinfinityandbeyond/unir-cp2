


data "template_cloudinit_config" "config" {
  gzip          = true
  base64_encode = true

  # Main cloud-config configuration file.
  part {
    content_type = "text/cloud-config"
    # Tuve muchos problemas con esta parte, al principio lo intenté con un templatefile pero había un problema al subirle las claves
    # Asi que al final con mucho esfuerzo y paciencia lo conseguí con el yamlencode, que ahi si me dejaba

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