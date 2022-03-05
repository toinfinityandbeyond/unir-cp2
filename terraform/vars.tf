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