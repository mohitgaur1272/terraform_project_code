variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnets" {
  description = "Public subnets for the EKS Cluster"
  type        = list(string)
}

variable "private_subnets" {
  description = "Private subnets for the EKS Cluster"
  type        = list(string)
}

variable "aws_region" {
  description = "AWS Region"
  type        = string
}

variable "vpc_name" {
  description = "VPC Name"
  type        = string
}

variable "ami_name" {
    description = "this is ami name" 
    type        = string
}

variable "instance_type" {
    description = "this is instance type" 
    type        = string
}