terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    encrypt = true
    region  = "eu-west-2"
    profile = "default"
  }
}

provider "aws" {
  region = "eu-west-2"
}

provider "aws" {
  alias  = "global"
  region = "us-east-1"
}
