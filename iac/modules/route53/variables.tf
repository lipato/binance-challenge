variable "env" {
  type = object({
    name         = string
    region       = string
    project_name = string
    domain_zone = string
    domain_name = string
  })
}

variable "domain_name" {
  type = string
}

variable "dns_name" {
  type = string
}

variable "zone_id" {
  type = string
}
