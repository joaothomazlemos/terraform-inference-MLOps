#especify the provider version ( hashicorp provider)
terraform {
  required_providers {
    #aws provider
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}