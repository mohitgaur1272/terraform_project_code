aws_region            = "ap-south-1"
vpc_name              = "mohit-ka-prod"
vpc_cidr              = "10.40.0.0/16"
public_subnets        = ["10.40.1.0/24", "10.40.2.0/24", "10.40.3.0/24"]
private_subnets       = ["10.40.4.0/24", "10.40.5.0/24", "10.40.6.0/24"]
ami_name              = "ami-0f5ee92e2d63afc18"
instance_type         = "t2.medium"
