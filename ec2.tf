# Create key_pair for connect ec2 instnaces
resource "aws_key_pair" "my_key" {
  key_name   = "${var.vpc_name}-key"
  public_key = file("C:/Users/mohit gaur/.ssh/id_rsa.pub")  # Use forward slashes or double backslashes
}

# Jump Server in Public Subnet
resource "aws_instance" "jump_server" {
  ami                    = var.ami_name  # Amazon Linux 2 AMI (ap-south-1)
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public[0].id  # First public subnet
  vpc_security_group_ids = [aws_security_group.jump_server_sg.id]
  key_name               = aws_key_pair.my_key.key_name
  root_block_device {
    volume_size = 20  # 20 GB storage
  }

  tags = {
    Name = "jump-server-public"
  }
}

# Private Servers in Private Subnets
resource "aws_instance" "private_servers" {
  count                  = 2
  ami                    = var.ami_name # Amazon Linux 2 AMI (ap-south-1)
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.private[count.index % length(aws_subnet.private)].id  # Subnets repeat honge
  vpc_security_group_ids = [aws_security_group.private_server_sg.id]
  key_name               = aws_key_pair.my_key.key_name
  root_block_device {
    volume_size = 20  # 20 GB storage
  }

  tags = {
    Name = "private-server-${count.index + 1}"
  }
}
