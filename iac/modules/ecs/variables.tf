variable "env" {
  type = object({
    name         = string
    region       = string
    project_name = string
  })
}

variable "public_subnets" {
  type = list(string)
}

variable "public_security_groups" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

variable "ecs_security_groups" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}

variable "certificate_arn" {
  type = string
}

variable "docker-image" {
  type = string
}
