aws_region            = "ap-south-1"
vpc_name              = "mohit-ka-dev"
vpc_cidr              = "10.20.0.0/16"
public_subnets        = ["10.20.1.0/24", "10.20.2.0/24", "10.20.3.0/24"]
private_subnets       = ["10.20.4.0/24", "10.20.5.0/24", "10.20.6.0/24"]
ami_name              = "ami-0f5ee92e2d63afc18"
instance_type         = "t2.medium"
