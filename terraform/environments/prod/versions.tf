terraform {
  required_version = ">= 1.5.0"

  cloud {
    organization = "aws-landing-zone"

    workspaces {
      name = "ai-image-gallery-prod"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}