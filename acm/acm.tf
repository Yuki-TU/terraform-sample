resource "aws_acm_certificate" "point_app" {
  domain_name               = "*.${var.domain}" # ワイルドカード証明書の場合はドメイン名も含める
  subject_alternative_names = [var.domain]      # ワイルドカード証明書の場合はドメイン名も含める
  validation_method         = "DNS"             # DNS or EMAIL 自動更新はDNSしか対応していない
  lifecycle {
    create_before_destroy = true # リソースの更新時に新しいリソースを作成してから古いリソースを削除する
  }
  tags = { Name = "${local.fqn}-acm" }
}
