variable "vms" {
  description = "Virtual machines to create"
  type        = list(string)
  default     = ["master", "worker01", "worker02", "nfs"]
}
variable "enviroment" {
  description = "environment tag"
  type        = string
  default     = "Terraform cp2"
}

variable "private_key_path" {
  type        = string
  description = "Ruta para la clave privada de acceso a las instancias"
  default     = "~/.ssh/sshKey.pem" # o la ruta correspondiente
}