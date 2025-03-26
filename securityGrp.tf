# Security Group for Jump Server
resource "aws_security_group" "jump_server_sg" {
  name        = "jump-server-sg"
  description = "Allow SSH from anywhere"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
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
    Name = "jump-server-sg"
  }
}

# Security Group for Private Servers
resource "aws_security_group" "private_server_sg" {
  name        = "private-server-sg"
  description = "Allow SSH only from Jump Server"
  vpc_id      = aws_vpc.vpc.id

# ✅ SSH Allowed from All Private Subnets (Dynamically from tfvars)
  dynamic "ingress" {
    for_each = var.private_subnets
    content {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [ingress.value]
    }
  }  
  
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.jump_server_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "private-server-sg"
  }
}

# Security Group for ALB
resource "aws_security_group" "alb_sg" {
  name        = "alb-sg"
  description = "Allow HTTP traffic from anywhere"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
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
    Name = "alb-sg"
  }
}