resource "aws_instance" "my_instance1" {
  ami           = "ami-0a7cf821b91bcccbc" # Replace with your desired AMI ID
  instance_type = "t2.micro"
  key_name      = "hello1"     # Replace with your key pair name
  count         = 1
  security_groups = ["my-sg"]
  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y apache2
              echo "this is first web server" > /var/www/html/index.html
              systemctl start apache2
              systemctl enable apache2
              EOF
  tags = {
    Name        = "my-instance1"
    Environment = "production"
  }
}

resource "aws_instance" "my_instance2" {
  ami           = "ami-0a7cf821b91bcccbc" # Replace with your desired AMI ID
  instance_type = "t2.micro"
  key_name      = "hello1"     # Replace with your key pair name
  count         = 1
  security_groups = ["my-sg"]
  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y apache2
              echo "this is second web server" > /var/www/html/index.html
              systemctl start apache2
              systemctl enable apache2
              EOF
  tags = {
    Name        = "my-instance2"
    Environment = "production"
  }
}
