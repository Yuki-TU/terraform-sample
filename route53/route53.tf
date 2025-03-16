resource "aws_route53_zone" "point_app" {
  name = var.domain
  tags = { Name = var.domain }
}

resource "aws_route53_record" "api" {
  zone_id = aws_route53_zone.point_app.zone_id
  name    = "api.${var.domain}"
  type    = "A"
  alias {
    name                   = data.terraform_remote_state.alb.outputs.alb.dns_name
    zone_id                = data.terraform_remote_state.alb.outputs.alb.zone_id
    evaluate_target_health = true
  }
}
