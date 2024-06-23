output "vpc" {
  value = {
    arn                = aws_vpc.vpc.arn
    id                 = aws_vpc.vpc.id
    cidr_block         = aws_vpc.vpc.cidr_block
    public_subnet_ids  = [for s in aws_subnet.public_subnet : s.id]
    private_subnet_ids = [for s in aws_subnet.private_subnet : s.id]
  }
}
