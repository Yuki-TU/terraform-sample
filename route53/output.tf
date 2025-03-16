output "host_zone" {
  value = {
    id   = aws_route53_zone.point_app.id
    name = aws_route53_zone.point_app.name
  }
}
