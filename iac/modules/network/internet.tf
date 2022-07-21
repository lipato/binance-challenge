resource "aws_internet_gateway" "internet-igw" {
  vpc_id = aws_vpc.this.id
}

resource "aws_eip" "nat-eip-a" {
  vpc   = true
}

resource "aws_nat_gateway" "nat-gw-a" {
  subnet_id     = aws_subnet.public-subnet-a.id
  allocation_id = aws_eip.nat-eip-a.id
}

