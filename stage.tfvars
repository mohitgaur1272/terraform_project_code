aws_region            = "ap-south-1"
vpc_name              = "mohit-ka-stage"
vpc_cidr              = "10.30.0.0/16"
public_subnets        = ["10.30.1.0/24", "10.30.2.0/24", "10.30.3.0/24"]
private_subnets       = ["10.30.4.0/24", "10.30.5.0/24", "10.30.6.0/24"]
ami_name              = "ami-0f5ee92e2d63afc18"
instance_type         = "t2.medium"
