variable "aws_region" {
  description = "AWS Region"
  type     = string
}

variable "environment" {
  description = "Deployment environment (dev/prod)"
  type        = string
}

variable "instance_type" {
  description = "EC2 Instance Type"
  type        = string
}

variable "ami_name" {
  description = "this is for ami name"
  type = string  
}