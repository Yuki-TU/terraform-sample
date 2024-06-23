resource "aws_nat_gateway" "nat_gateway" {
  for_each      = var.private_subnet
  allocation_id = aws_eip.nat_gateway[each.key].id
  subnet_id     = aws_subnet.public_subnet[each.key].id
  depends_on    = [aws_internet_gateway.ig]
  tags = {
    Name = "${local.fqn}-nat-gateway-${each.key}"
  }
}
