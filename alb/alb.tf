resource "aws_lb" "alb" {
  name            = "${local.fqn}-alb"
  internal        = false
  subnets         = data.terraform_remote_state.network.outputs.vpc.public_subnet_ids
  security_groups = [aws_security_group.alb.id]

  # access_logs {
  # enabled = true
  # bucket  = var.s3_log_bucket_id
  # prefix  = "alb/${local.fqn}-alb"
  # }

  tags = { Name = "${local.fqn}-alb" }
}

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "https_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn   = data.terraform_remote_state.acm.outputs.acm.arn
  default_action {
    # デフォルトでリスナールールにマッチしないリクエストは、404を返す
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      status_code  = "404"
      message_body = "Not Found"
    }
  }
}

resource "aws_lb_target_group" "api" {
  name        = "${local.fqn}-api"
  target_type = "ip" # ECSの場合はip
  port        = 80
  protocol    = "HTTP"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc.id
  health_check {
    enabled             = true
    interval            = 30
    path                = "/health"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
  depends_on = [aws_lb.alb] # albが先に作成されるようにする
  tags       = { Name = "${local.fqn}-api" }
}

resource "aws_lb_listener_rule" "api" {
  listener_arn = aws_lb_listener.https_listener.arn
  priority     = 100
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.api.arn
  }
  condition {
    path_pattern {
      values = ["/*"]
    }
  }
}
