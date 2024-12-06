variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "runner_count" {
  type    = number
  default = 4
}

variable "vm_size" {
  type    = string
  default = "Standard_DS1_v2"
}

variable "admin_username" {
  type    = string
  default = "adminuser"
}

variable "github_token" {
  type      = string
  sensitive = true
}

variable "github_repo_url" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "os_disk_size_gb" {
  description = "Size of OS disk in GB"
  type        = number
  default     = 128
}

variable "os_disk_type" {
  description = "Type of OS disk"
  type        = string
  default     = "Standard_LRS"
}

variable "image_publisher" {
  description = "Publisher for the VM image"
  type        = string
  default     = "Canonical"
}

variable "image_offer" {
  description = "Offer for the VM image"
  type        = string
  default     = "UbuntuServer"
}

variable "image_sku" {
  description = "SKU for the VM image"
  type        = string
  default     = "18.04-LTS"
}