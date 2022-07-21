variable "env" {
  type = object({
    name         = string
    region       = string
    project_name = string
  })
}

variable "vpc_cidr" {
  type = string
}

variable "subnets" {
  type = object ({
    public-subnet-a  = string
    public-subnet-b  = string
    private-subnet-a = string
    private-subnet-b = string
  })
}
