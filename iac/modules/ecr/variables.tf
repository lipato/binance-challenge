variable "env" {
  type = object({
    name         = string
    region       = string
    project_name = string
  })
}

variable "accounts" {
  type = list(string)
}

variable "name" {
  type = string
}

variable "kms_key" {
  type = string
}