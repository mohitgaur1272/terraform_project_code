resource "aws_key_pair" "mykey" {
     key_name = "mohit_ki_key"
     public_key = file("C:/Users/Raj/.ssh/id_rsa.pub") #path of your local system public key 
}

resource "aws_instance" "my_instance1" {
  ami           = "ami-05e00961530ae1b55" # Replace with your desired AMI ID
  instance_type = "t2.micro"
  key_name      = aws_key_pair.mykey.key_name # Replace with your key pair name
  count         = 1
  security_groups = ["22_may"]
  user_data = "${file("prometheus.sh")}"
  tags = {
    Name        = "prometheus"
    Environment = "production"
  }
  # Root EBS Volume Configuration
  root_block_device {
    volume_type = "gp2"
    volume_size = 10 # Size in GB
    delete_on_termination = true
  }
}


resource "aws_instance" "my_instance2" {
  ami           = "ami-05e00961530ae1b55" # Replace with your desired AMI ID
  instance_type = "t2.micro"
  key_name      = aws_key_pair.mykey.key_name     # Replace with your key pair name
  count         = 1
  security_groups = ["22_may"]
  user_data = "${file("grafana.sh")}"
  tags = {
    Name        = "grafana"
    Environment = "production"
  }
  # Root EBS Volume Configuration
  root_block_device {
    volume_type = "gp2"
    volume_size = 10 # Size in GB
    delete_on_termination = true
  }
}
