terraform {
  required_providers {
    aws = {
      version = "~> 5.0"
      source  = "hashicorp/aws"
    }
    awscc = {
      version = "~> 1.0"
      source  = "hashicorp/awscc"
    }
    random = {
      version = "~> 3.0"
      source  = "hashicorp/random"
    }
  }
  required_version = ">= 1.0.1"
}
