resource "aws_instance" "my_instance1" {
  ami           = "ami-05e00961530ae1b55" # Replace with your desired AMI ID
  instance_type = "t2.micro"
  key_name      = aws_key_pair.mykey.key_name     # Replace with your key pair name
  count         = 1
  security_groups = ["21_may"]
  user_data = "${file("user_data1.sh")}"
  tags = {
    Name        = "21_may_1"
    Environment = "production"
  }
}

resource "aws_instance" "my_instance2" {
  ami           = "ami-05e00961530ae1b55" # Replace with your desired AMI ID
  instance_type = "t2.micro"
  key_name      = aws_key_pair.mykey.key_name     # Replace with your key pair name
  count         = 1
  security_groups = ["21_may"]
  user_data = "${file("user_data2.sh")}"
  tags = {
    Name        = "21_may_2"
    Environment = "production"
  }
}