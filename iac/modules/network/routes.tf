resource "aws_route_table" "public-subnet-rt-a" {
  vpc_id = aws_vpc.this.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet-igw.id
  }
  lifecycle {
    ignore_changes = [
      route,
    ]
  }
}

resource "aws_route_table" "public-subnet-rt-b" {
  vpc_id = aws_vpc.this.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet-igw.id
  }
  lifecycle {
    ignore_changes = [
      route,
    ]
  }
}

resource "aws_route_table_association" "public-routes-assoc-a" {
  subnet_id      = aws_subnet.public-subnet-a.id
  route_table_id = aws_route_table.public-subnet-rt-a.id
}

resource "aws_route_table_association" "public-routes-assoc-b" {
  subnet_id      = aws_subnet.public-subnet-b.id
  route_table_id = aws_route_table.public-subnet-rt-b.id
}


resource "aws_route_table" "private-subnet-rt-b" {
  vpc_id = aws_vpc.this.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw-a.id
  }
  lifecycle {
    ignore_changes = [
      route,
    ]
  }
}

resource "aws_route_table" "private-subnet-rt-a" {
  vpc_id = aws_vpc.this.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw-a.id
  }
  lifecycle {
    ignore_changes = [
      route,
    ]
  }
}

resource "aws_route_table_association" "private-routes-assoc-a" {
  subnet_id      = aws_subnet.private-subnet-a.id
  route_table_id = aws_route_table.private-subnet-rt-a.id
}

resource "aws_route_table_association" "private-routes-assoc-b" {
  subnet_id      = aws_subnet.private-subnet-b.id
  route_table_id = aws_route_table.private-subnet-rt-b.id
}