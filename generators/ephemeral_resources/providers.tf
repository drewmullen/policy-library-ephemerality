terraform {
  required_providers {
    # Please add new providers to this list as desired
    aws = {
      source  = "hashicorp/aws"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
    }
    tfe = {
      source  = "hashicorp/tfe"
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

