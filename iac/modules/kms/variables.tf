variable "env" {
  type = object({
    name         = string
    region       = string
    project_name = string
  })
}
