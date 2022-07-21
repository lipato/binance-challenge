output "ecs_role_name" {
  value = aws_iam_role.role.arn
}

output "alb_dns_name" {
  value = aws_lb.ext.dns_name
}

output "alb_zone_id" {
  value = aws_lb.ext.zone_id
}