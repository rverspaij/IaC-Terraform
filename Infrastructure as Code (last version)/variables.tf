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

variable "username" {
  description = "Fill in your username that you would like to use for your machines."
  type = string
  sensitive = false
}

variable "password" {
  description = "Fill your password that you want to use for your machines."
  type = string
  sensitive = true
}

variable "default-location" {
  default = "westeurope"
}

variable "projName" {
  description = "String for globally unique resources"
  default     = "raoul"
  type        = string
}