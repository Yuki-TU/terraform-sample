resource "aws_eip" "nat_gateway" {
  domain     = "vpc"
  for_each   = var.public_subnet
  depends_on = [aws_internet_gateway.ig]
  tags = {
    Name = "${local.fqn}-nat-gateway-eip-${each.key}"
  }
}
