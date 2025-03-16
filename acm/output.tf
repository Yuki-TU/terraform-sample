output "acm" {
  value = {
    arn                       = aws_acm_certificate.point_app.arn
    id                        = aws_acm_certificate.point_app.id
    domain_validation_options = aws_acm_certificate.point_app.domain_validation_options
  }
}
