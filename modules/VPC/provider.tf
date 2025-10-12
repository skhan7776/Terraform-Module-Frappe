terraform {
  # Works with Terraform 1.9.x up to 1.13.x
  required_version = ">= 1.9.0, < 1.14.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      # Compatible with both v5 and v6 major releases
      version = ">= 5.0.0, < 7.0.0"
    }
  }
}