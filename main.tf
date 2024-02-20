#create a new security group within the new VPC
resource "aws_security_group" "my_security_group" {
  name        = "my-sg"
  description = "My example security group"
  vpc_id      = "vpc-0794fde5cab1c1c34"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080  # Docker port
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "my-security-group"
    Environment = "production"
  }
}

# Create a new key pair
resource "aws_key_pair" "my_key_pair" {
  key_name   = "MOHIT_KI_KEY" # Specify the name for your key pair
  public_key = file("/home/ubuntu/.ssh/id_rsa.pub") # Path to your public key file
}

# Launch an instance within the new VPC
resource "aws_instance" "my_instance1" {
  ami                    = "ami-0a7cf821b91bcccbc" # Replace with your desired AMI ID
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.my_key_pair.key_name # Reference the key pair created above
  count                  = 1
  vpc_security_group_ids = [aws_security_group.my_security_group.id]
  subnet_id              = "subnet-08862ae7dee8aa99b"  # Specify the subnet ID within the new VPC
  user_data = "${file("user-data-apache.sh")}"



tags = {
    Name        = "my-instance1"
    Environment = "production"
  }
}

