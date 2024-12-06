variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default     = {}
}

variable "github_repo_url" {
  description = "GitHub repository URL"
  type        = string
}

variable "github_token" {
  description = "GitHub runner token"
  type        = string
  sensitive   = true
}