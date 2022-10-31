resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags       = merge(local.common_tags, { Name = replace(local.name, "rtype", "vpc") })
}
resource "aws_subnet" "pub_sub" {
  count                   = length(var.cidr_pubs)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = element(var.cidr_pubs, count.index)
  map_public_ip_on_launch = true
  availability_zone       = element(var.azs, count.index)
  tags = {
    "Name" = "${var.env}-public-subnet-${count.index}"
  }
}
resource "aws_subnet" "priv_sub" {
  count             = length(var.cidr_privs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.cidr_privs, count.index)
  availability_zone = element(var.azs, count.index)
  tags = {
    "Name" = "${var.env}-private-subnet-${count.index}"
  }
}
resource "aws_internet_gateway" "internet" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.env}-igw"
  }
}
resource "aws_eip" "eip" {
  vpc = true
  depends_on = [
    aws_internet_gateway.internet
  ]
}
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.pub_sub[0].id
  tags = {
    "Name" = "${var.env}-NGW"
  }
}
resource "aws_route_table" "pub-route-table" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.env}-pub-rt"
  }
}
resource "aws_route_table" "priv-route-table" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.env}-priv-rt"
  }
}
resource "aws_route" "internet-route" {
  route_table_id         = aws_route_table.pub-route-table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internet.id

}
resource "aws_route_table_association" "rt_pubsub" {
  count          = length(aws_subnet.pub_sub)
  subnet_id      = element(aws_subnet.pub_sub.*.id, count.index)
  route_table_id = aws_route_table.pub-route-table.id
}
resource "aws_route_table_association" "rt_privsub-1" {
  count          = length(aws_subnet.priv_sub)
  subnet_id      = element(aws_subnet.priv_sub.*.id, count.index)
  route_table_id = aws_route_table.priv-route-table.id
}
resource "aws_route" "nat-route" {
  route_table_id         = aws_route_table.priv-route-table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gw.id
}