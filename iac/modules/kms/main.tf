resource "aws_kms_key" "kms-key" {
  description  = "KMS key for ${var.env.name}"
}

resource "aws_kms_alias" "kms-alias" {
  name          = "alias/${var.env.project_name}-kms-${var.env.name}-key"
  target_key_id = aws_kms_key.kms-key.key_id
}
