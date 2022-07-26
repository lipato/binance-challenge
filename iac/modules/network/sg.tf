resource "aws_security_group" "ecs-sg" {
  name        = "${var.env.project_name}-ecs-sg"
  description = "Access between containers, access to ALB"
  vpc_id      = aws_vpc.this.id

  ingress {
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    security_groups = [
      aws_security_group.pub-alb-sg.id
    ]
  }

  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = [
      "0.0.0.0/0"
    ]
  }

  egress {
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    security_groups      = [
      aws_security_group.pub-alb-sg.id
    ]
  }

  egress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = [
      "0.0.0.0/0"
    ]
  }
}

resource "aws_security_group" "pub-alb-sg" {
  name        = "${var.env.project_name}-public-alb-sg"
  description = "Access to the Application LoadBalancer from internet"
  vpc_id      = aws_vpc.this.id

  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}
