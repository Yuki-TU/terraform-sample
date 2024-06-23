# Route Table for Public Subnet
# パブリックサブネット用のルートテーブルはひとつ作成し、共有する
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${local.fqn}-public-route-table"
  }
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.ig.id
}

resource "aws_route_table_association" "public" {
  for_each       = aws_subnet.public_subnet
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

# Route Table for Private Subnet
# プライベートサブネット用のルートテーブルはサブネットごとに作成する
resource "aws_route_table" "private" {
  for_each = var.private_subnet
  vpc_id   = aws_vpc.vpc.id
  tags = {
    Name = "${local.fqn}-private-route-table-${each.value["az"]}"
  }
}

resource "aws_route" "private_nat_gateway" {
  for_each               = var.private_subnet
  route_table_id         = aws_route_table.private[each.key].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gateway[each.key].id
}

resource "aws_route_table_association" "private" {
  for_each       = var.private_subnet
  subnet_id      = aws_subnet.private_subnet[each.key].id
  route_table_id = aws_route_table.private[each.key].id
}
