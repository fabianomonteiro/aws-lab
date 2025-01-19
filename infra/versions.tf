terraform {
  required_version = ">= 1.10.4" # Versão mínima do Terraform que você deseja usar

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.84.0" # Atualize para a versão necessária
    }
  }
}