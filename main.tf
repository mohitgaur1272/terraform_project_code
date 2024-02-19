# Create a new security group within the new VPC
resource "aws_security_group" "my_security_group" {
  name        = "my-sg"
  description = "My example security group"
  vpc_id      = "paste_your_vpc_id"

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
  subnet_id     = "paste_your_subnet_id"  # Specify the subnet ID within the new VPC
  user_data = <<-EOF
              #!/bin/bash
              sudo touch install_apache_docker_jenkins.sh
              echo '#!/bin/bash

             # Update package list
             sudo apt-get update

             # Install Apache2 
             sudo apt-get install -y apache2

             # Start Apache2 service and enable it to start on boot
             sudo systemctl start apache2
             sudo systemctl enable apache2

            # Install Docker
            sudo apt-get install -y docker.io

            # Adjust permissions for Docker socket
            sudo chmod 777 /var/run/docker.sock

            # Add user to the docker group
            sudo usermod -aG docker ubuntu

            # Install OpenJDK 11
            sudo apt update -y
            sudo apt install openjdk-11-jdk -y

            # Add Jenkins GPG key
            curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo gpg --dearmor -o /usr/share/keyrings/jenkins-keyring.gpg

            # Add Jenkins repository
            echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.gpg] \
               https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
             /etc/apt/sources.list.d/jenkins.list > /dev/null

            # Update package list
            sudo apt update -y

            # Install Jenkins
            sudo apt install jenkins -y

            # Start Jenkins service and enable it to start on boot
            sudo systemctl start jenkins
            sudo systemctl enable jenkins' >    

            sudo chmod +x install_apache_docker_jenkins.sh 
            sudo ./install_apache_docker_jenkins.sh 
            EOF
  tags = {
    Name        = "my-instance1"
    Environment = "production"
  }
}
