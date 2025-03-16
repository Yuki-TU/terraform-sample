data "terraform_remote_state" "alb" {
  backend = "s3"
  config = {
    bucket = "point-app-tfstate-${var.env}"
    key    = "alb/terraform.tfstate"
    region = var.region
    # ローカル用の設定
    use_path_style              = var.env == "local" ? true : null
    skip_credentials_validation = var.env == "local" ? true : null
    skip_metadata_api_check     = var.env == "local" ? true : null
    skip_requesting_account_id  = var.env == "local" ? true : null
    endpoints = var.env == "local" ? {
      sts = "http://localhost:5001"
      s3  = "http://localhost:5001"
    } : null
  }
}
