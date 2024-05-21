terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "=5.45.0"
    }
  }
  required_version = ">=1.7.5"
}

# Configure Default AWS Provider Region
provider "aws" {
  region = "eu-central-1"
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  token                  = module.eks.token
}

provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    token                  = module.eks.token
  }
}