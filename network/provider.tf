terraform {
  backend "s3" {
    region = "ap-northeast-1"
    # ローカルの設定 start
    access_key     = "minioadmin"
    secret_key     = "minioadmin"
    use_path_style = true
    endpoints = {
      s3  = "http://localhost:4566"
      sts = "http://localhost:4566"
    }
    # ローカルの設定 end
  }
  required_version = "1.8.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.55"
    }
  }
}

provider "aws" {
  region = var.region
  default_tags {
    tags = {
      Service = var.service
      Env     = var.env
    }
  }
  # ローカルの設定 start
  access_key                  = "minioadmin"
  secret_key                  = "minioadmin"
  s3_use_path_style           = true
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
  endpoints {
    # s3             = "http://s3.localhost.localstack.cloud:4566"
    # s3             = "http://localhost:9000"
    s3  = "http://localhost:4566"
    ec2 = "http://localhost:4566"
  }
  # ローカルの設定 end
}
