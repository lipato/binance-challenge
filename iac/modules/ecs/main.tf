resource "aws_ecs_cluster" "this" {
  name = "ecs-cluster"
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
