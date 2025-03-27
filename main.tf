resource "aws_instance" "my_ec2" {
  ami           = var.ami_name # Change as per AWS region
  instance_type = var.instance_type

  tags = {
    Name        = "Terraform-EC2-${var.environment}"
    Environment = var.environment
  }
}
