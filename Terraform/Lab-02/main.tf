terraform {
  required_providers {
    local = {
      source = "hashicorp/local"
    }
  }
}

resource "local_file" "cloud_lab" {
  filename = "${path.module}/${var.file_name}"

  content = <<EOF
Terraform Cloud Lab
Environment: ${var.environment}
Managed by Terraform
EOF
}
