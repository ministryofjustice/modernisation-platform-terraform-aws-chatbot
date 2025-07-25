terraform {
  required_providers {
    aws = {
      version = "~> 6.0"
      source  = "hashicorp/aws"
    }
    http = {
      source  = "hashicorp/http"
      version = "~> 3.3"
    }
  }
  required_version = "~> 1.0"
}
