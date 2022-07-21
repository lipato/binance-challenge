# === create role
resource "aws_iam_role" "role" {
  name               = "${var.env.project_name}-TaskRole"
  assume_role_policy = data.aws_iam_policy_document.assume_policy.json
}

data "aws_iam_policy_document" "assume_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "role_policy_attachment" {
  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.role_policy.arn
}

resource "aws_iam_policy" "role_policy" {
  name        = "${var.env.project_name}-task-policy"
  description = "Policy that allows access to Services"
  policy      = data.aws_iam_policy_document.role_policy_document.json
}

data "aws_iam_policy_document" "role_policy_document" {
  statement {
    actions   = [
      "es:*",
      "ecr:BatchCheckLayerAvailability",
      "ecr:BatchGetImage",
      "ecr:GetDownloadUrlForLayer",
      "ecr:GetAuthorizationToken",
    ]
    resources = ["*"]
  }
}

resource "aws_iam_role" "execution_role" {
  name               = "${var.env.project_name}-Task-ecsExecRole"
  assume_role_policy = data.aws_iam_policy_document.assume_execution_role_policy.json
}

data "aws_iam_policy_document" "assume_execution_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "execution_role_policy_attachment" {
  role       = aws_iam_role.execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role_policy_attachment" "execution_role_policy_attachment2" {
  role       = aws_iam_role.execution_role.name
  policy_arn = aws_iam_policy.execution_role_policy.arn
}

resource "aws_iam_policy" "execution_role_policy" {
  name        = "${var.env.project_name}-execution-policy"
  description = "Policy that allows access to Services"
  policy      = data.aws_iam_policy_document.execution_role_policy_document.json
}

data "aws_iam_policy_document" "execution_role_policy_document" {
  statement {
    actions   = [
      "logs:CreateLogGroup",
    ]
    resources = ["*"]
  }
}
