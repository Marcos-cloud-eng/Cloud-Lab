output "managed_file" {
  description = "Path of the file managed by Terraform"
  value       = local_file.cloud_lab.filename
}

output "environment" {
  description = "Environment used in this lab"
  value       = var.environment
}
