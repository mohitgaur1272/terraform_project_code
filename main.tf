# Define the existing EC2 instance using its instance ID
data "aws_instance" "example" {
  instance_id = "i-0123456789abcdef0"  # Replace this with your instance ID
}

# Create an AMI from the existing instance
resource "aws_ami_from_instance" "example" {
  name               = "example-ami"
  source_instance_id = data.aws_instance.example.id
}

# Create a snapshot of the root volume of the existing instance
resource "aws_ebs_snapshot" "example" {
  volume_id = data.aws_instance.example.root_block_device[0].volume_id
}

# Define a launch configuration for instances in the ASG
resource "aws_launch_configuration" "example" {
  name_prefix                 = "example-lc-"
  image_id                    = aws_ami_from_instance.example.image_id
  instance_type               = "t2.micro"               # Instance type
  security_groups             = ["sg-0123456789abcdef0"] # Replace with your security group ID
  key_name                    = "my-key-pair"           # Your key pair name
  user_data                   = file("userdata.sh")     # Path to your user data script
  lifecycle { create_before_destroy = true }
}

# Define an Auto Scaling Group
resource "aws_autoscaling_group" "example" {
  name                     = "example-asg"
  launch_configuration     = aws_launch_configuration.example.id
  min_size                 = 2
  max_size                 = 5
  desired_capacity         = 2
  vpc_zone_identifier      = ["subnet-0123456789abcdef0"]  # Replace with your subnet ID
  health_check_type        = "ELB"
  health_check_grace_period = 300
  termination_policies     = ["OldestLaunchConfiguration", "Default"]
  tag {
    key                 = "Name"
    value               = "example-instance"
    propagate_at_launch = true
  }
}

# Define a Load Balancer
resource "aws_lb" "example" {
  name               = "example-lb"
  internal           = false
  load_balancer_type = "application"
  subnets            = ["subnet-0123456789abcdef0"]  # Replace with your subnet ID
  security_groups    = ["sg-0123456789abcdef0"]      # Replace with your security group ID
}

# Define a Target Group
resource "aws_lb_target_group" "example" {
  name        = "example-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = "vpc-0123456789abcdef0"  # Replace with your VPC ID
}

# Attach ASG to Target Group
resource "aws_autoscaling_attachment" "example" {
  autoscaling_group_name = aws_autoscaling_group.example.name
  alb_target_group_arn   = aws_lb_target_group.example.arn
}
