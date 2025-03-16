output "alb" {
  value = {
    id                  = aws_lb.alb.id
    arn                 = aws_lb.alb.arn
    dns_name            = aws_lb.alb.dns_name
    zone_id             = aws_lb.alb.zone_id
    name                = aws_lb.alb.name
    https_listener_arn  = aws_lb_listener.https_listener.arn
    security_group_arn  = aws_security_group.alb.arn
    security_group_id   = aws_security_group.alb.id
    security_group_name = aws_security_group.alb.name
  }
}
