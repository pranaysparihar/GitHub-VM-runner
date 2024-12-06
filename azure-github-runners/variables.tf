variable "resource_group_name" {
  type    = string
  default = "github-runners-rg"
}

variable "project_name" {
  type    = string
  default = "github-runners"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "location" {
  type    = string
  default = "eastus"
}

variable "vnet_address_space" {
  type    = list(string)
  default = ["10.0.0.0/16"]
}

variable "subnet_prefix" {
  type    = list(string)
  default = ["10.0.1.0/24"]
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