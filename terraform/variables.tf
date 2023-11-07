variable "env" {
  type        = string
  description = "Environment"
  default     = "dev"
  validation {
    condition     = contains(["dev", "prod"], var.env)
    error_message = "The 'env' must be either 'dev' or 'prod'."
  }
}

variable "project" {
  type        = string
  description = "Project"
  nullable    = false
}
