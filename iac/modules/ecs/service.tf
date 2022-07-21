resource "aws_ecs_service" "binance-challenge-service" {
 name                               = "${var.env.project_name}-Task-Service"
 cluster                            = aws_ecs_cluster.this.id
 task_definition                    = aws_ecs_task_definition.binance-challenge-task-definition.arn
 desired_count                      = 2
 deployment_minimum_healthy_percent = 50
 deployment_maximum_percent         = 300
 launch_type                        = "FARGATE"
 scheduling_strategy                = "REPLICA"

 network_configuration {
   security_groups  = var.ecs_security_groups
   subnets          = var.private_subnets
   assign_public_ip = false
 }

 load_balancer {
   target_group_arn = aws_alb_target_group.alb-target-group.arn
   container_name   = "BinanceChallenge"
   container_port   = "8080"
 }

 lifecycle {
   ignore_changes = [task_definition, desired_count]
 }
}