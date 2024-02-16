# Create a new VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16" # Specify the CIDR block for your VPC
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "my-vpc"
  }
}

# Create a new security group within the new VPC
resource "aws_security_group" "my_security_group" {
  name        = "my-sg"
  description = "My example security group"
  vpc_id      = aws_vpc.my_vpc.id

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
  public_key = file("~/.ssh/id_rsa.pub") # Path to your public key file
}

# Launch an instance within the new VPC
resource "aws_instance" "my_instance1" {
  ami           = "ami-0a7cf821b91bcccbc" # Replace with your desired AMI ID
  instance_type = "t2.micro"
  key_name      = aws_key_pair.my_key_pair.key_name # Reference the key pair created above
  count         = 1
  vpc_security_group_ids = [aws_security_group.my_security_group.id]
  subnet_id     = aws_subnet.my_subnet.id  # Specify the subnet ID within the new VPC
  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y apache2
              systemctl start apache2
              systemctl enable apache2

              # Install Docker
              apt-get install -y docker.io

              # Install Jenkins 
              apt install openjdk-11-jdk -y
              curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
              /usr/share/keyrings/jenkins-keyring.asc > /dev/null

              echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] 
              \https://pkg.jenkins.io/debian-stable binary/ | sudo tee \ 
              /etc/apt/sources.list.d/jenkins.list > /dev/null

              apt update -y
              apt install jenkins -y
              systemctl start jenkins
              systemctl enable jenkins
             EOF
  tags = {
    Name        = "my-instance1"
    Environment = "production"
  }
}

# Create a subnet within the new VPC
resource "aws_subnet" "my_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.0.0/24" # Specify the CIDR block for your subnet
  availability_zone        = "your-chosen-availability-zone" # Replace with your chosen availability zone

  map_public_ip_on_launch = true # Set to false if you don't want instances in this subnet to have public IPs

  tags = {
    Name = "my-subnet"
  }
}
