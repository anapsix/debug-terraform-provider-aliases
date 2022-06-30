terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.2"
    }
  }

  required_version = ">= 1.1"
}

provider "aws" {
  region = "ap-northeast-1"
}

provider "aws" {
  region = "us-west-2"
  alias  = "one"
}

module "clone1" {
  providers = {
    aws.one = aws.one
  }
  source = "./modules/one"
}

module "clone2" {
  providers = {
    aws     = aws
    aws.one = aws.one
  }
  source = "./modules/one"
}
