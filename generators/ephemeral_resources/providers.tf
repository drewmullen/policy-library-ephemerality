terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
    }
    tls = {
      source  = "hashicorp/tls"
    }
    random = {
      source  = "hashicorp/random"
    }
    google = {
      source  = "hashicorp/google"
    }
    azuread = {
      source  = "hashicorp/azuread"
    }
  }
}

