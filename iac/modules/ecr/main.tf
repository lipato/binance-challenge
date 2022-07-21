resource "aws_ecr_repository" "this" {
  name                 = var.name
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
  encryption_configuration {
    encryption_type = "KMS"
    kms_key = var.kms_key
  }
}

resource "aws_ecr_repository_policy" "policy" {
  repository = aws_ecr_repository.this.name

  policy = data.aws_iam_policy_document.policy_document.json
}

data "aws_iam_policy_document" "policy_document" {
  statement {
    actions = [
      "ecr:*"
    ]
    effect = "Allow"
    principals {
      identifiers = local.accounts
      type        = "AWS"
    }
  }
}

locals {
  accounts = [ for account in var.accounts : "arn:aws:iam::${account}:root" ]
}