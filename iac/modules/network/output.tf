output "vpc" {
  value = aws_vpc.this
}

output "private-subnet-a" {
  value = aws_subnet.private-subnet-a.id
}

output "private-subnet-b" {
  value = aws_subnet.private-subnet-b.id
}

output "public-subnet-a" {
  value = aws_subnet.public-subnet-a.id
}

output "public-subnet-b" {
  value = aws_subnet.public-subnet-b.id
}

output "ecs-security-group" {
  value = aws_security_group.ecs-sg.id
}

output "public-alb-security-group" {
  value = aws_security_group.pub-alb-sg.id
}
