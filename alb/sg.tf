resource "aws_security_group" "alb" {
  name        = "alb"
  description = "Allow inbound HTTPS traffic"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc.id
  tags = {
    Name = "${local.fqn}-sg-alb"
  }
}

resource "aws_vpc_security_group_ingress_rule" "alb_https" {
  security_group_id = aws_security_group.alb.id
  description       = "Allow HTTPS inbound traffic"
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_egress_rule" "alb_all" {
  security_group_id = aws_security_group.alb.id
  description       = "Allow all outbound traffic"
  cidr_ipv4         = "0.0.0.0/8"
  ip_protocol       = "-1" # all
}
