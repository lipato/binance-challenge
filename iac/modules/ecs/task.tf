resource "aws_ecs_task_definition" "binance-challenge-task-definition" {
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 1024
  memory                   = 2048
  execution_role_arn       = aws_iam_role.execution_role.arn
  task_role_arn            = aws_iam_role.role.arn
  family                   = "${var.env.project_name}-task"
  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
  container_definitions    = jsonencode([
    {
      essential    = true
      name         = "BinanceChallenge"
      image        = "${var.docker-image}:latest"
      portMappings = [
        {
          protocol      = "tcp",
          containerPort = 8080,
          hostPort      = 8080,
        }
      ]
      logConfiguration : {
        logDriver : "awslogs",
        options : {
          awslogs-group : "firelens-container",
          awslogs-region : var.env.region,
          awslogs-create-group : "true",
          awslogs-stream-prefix : "firelens"
        }
      },
      memoryReservation : 100,
    }
  ])
  lifecycle {
    ignore_changes = [
      container_definitions,
    ]
  }
}
