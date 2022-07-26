resource "aws_ecs_cluster" "this" {
  name = "ecs-cluster"
}

resource "aws_vpc_endpoint" "ecr-dkr" {
  vpc_id              = var.vpc_id
  auto_accept         = true
  private_dns_enabled = true
  service_name        = "com.amazonaws.${data.aws_region.current.name}.ecr.dkr"
  vpc_endpoint_type   = "Interface"
  security_group_ids = var.ecs_security_groups
  subnet_ids = var.private_subnets
}

resource "aws_vpc_endpoint" "ecr-api" {
  vpc_id              = var.vpc_id
  auto_accept         = true
  private_dns_enabled = true
  service_name        = "com.amazonaws.${data.aws_region.current.name}.ecr.api"
  vpc_endpoint_type   = "Interface"
  security_group_ids = var.ecs_security_groups
  subnet_ids = var.private_subnets
}

resource "aws_vpc_endpoint" "logs" {
  vpc_id              = var.vpc_id
  auto_accept         = true
  private_dns_enabled = true
  service_name        = "com.amazonaws.${data.aws_region.current.name}.logs"
  vpc_endpoint_type   = "Interface"
  security_group_ids = var.ecs_security_groups
  subnet_ids = var.private_subnets
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id              = var.vpc_id
  auto_accept         = true
  service_name        = "com.amazonaws.${data.aws_region.current.name}.s3"
  vpc_endpoint_type   = "Interface"
  security_group_ids = var.ecs_security_groups
  subnet_ids = var.private_subnets
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
