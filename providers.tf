provider "aws" {
  region                   = var.vpc_region
  shared_credentials_files = ["~/.aws/credentials"] ## Use only when you have two AWS Credentials in AWS CLI in Jenkins
  profile                  = "default"              ## Use only when you have two AWS Credentials in AWS CLI in Jenkins
}

provider "aws" {
  region                   = var.vpc_region_staging
  alias                    = "apse2"
  shared_credentials_files = ["~/.aws/credentials"] ## Use only when you have two AWS Credentials in AWS CLI in Jenkins
  profile                  = "default"              ## Use only when you have two AWS Credentials in AWS CLI in Jenkins
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}