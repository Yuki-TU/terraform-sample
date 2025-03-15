terraform {
  backend "s3" {
    region = "ap-northeast-1"
  }
  required_version = "1.11.2"
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
  s3_use_path_style           = var.env == "local" ? true : null
  skip_credentials_validation = var.env == "local" ? true : null
  skip_metadata_api_check     = var.env == "local" ? true : null
  skip_requesting_account_id  = var.env == "local" ? true : null
  dynamic "endpoints" {
    for_each = var.env == "local" ? [1] : []
    content {
      s3  = "http://localhost:5001"
      ec2 = "http://localhost:5001"
    }
  }
  # ローカルの設定 end
}
