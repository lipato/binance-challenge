data "aws_availability_zones" "az" {}

resource "aws_subnet" "private-subnet-a" {
  vpc_id     = aws_vpc.this.id
  cidr_block = var.subnets["private-subnet-a"]
  availability_zone = data.aws_availability_zones.az.names[0]
}

resource "aws_subnet" "private-subnet-b" {
  vpc_id     = aws_vpc.this.id
  cidr_block = var.subnets["private-subnet-b"]
  availability_zone = data.aws_availability_zones.az.names[1]
}

resource "aws_subnet" "public-subnet-a" {
  vpc_id     = aws_vpc.this.id
  cidr_block = var.subnets["public-subnet-a"]
  availability_zone = data.aws_availability_zones.az.names[0]
}

resource "aws_subnet" "public-subnet-b" {
  vpc_id     = aws_vpc.this.id
  cidr_block = var.subnets["public-subnet-b"]
  availability_zone = data.aws_availability_zones.az.names[1]
}
