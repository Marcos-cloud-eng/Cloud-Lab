terraform {
  required_providers {
    local = {
      source = "hashicorp/local"
    }
  }
}

resource "local_file" "first_lab" {
  filename = "${path.module}/terraform-lab.txt"
  content = "Terraform LAB 01 - Infrastructure as Code!"
}
