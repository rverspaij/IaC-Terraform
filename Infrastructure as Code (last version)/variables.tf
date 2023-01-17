locals {
  database = false
  docker   = true
}

variable "default-tags" {
  default = {
    Team        = "DevOps"
    Environment = "SchoolProject"
  }
}

variable "default-location" {
  default = "westeurope"
}

variable "projName" {
  description = "String for globally unique resources"
  default     = "raoul"
  type        = string
}