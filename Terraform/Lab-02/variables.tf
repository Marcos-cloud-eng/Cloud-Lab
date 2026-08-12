variable "file_name" {
  description = "Name of the file managed by Terraform"
  type        = string
  default     = "cloud-lab.txt"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "development"
}
