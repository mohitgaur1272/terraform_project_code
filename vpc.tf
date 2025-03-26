# 🚀 1. Create VPC 
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name ="${var.vpc_name}-vpc"
  }
}

# 2. Create public and private subnets
resource "aws_subnet" "public" {
  count             = length(var.public_subnets)
  vpc_id           = aws_vpc.vpc.id
  cidr_block       = var.public_subnets[count.index]
  map_public_ip_on_launch = true
  availability_zone = element(["ap-south-1a", "ap-south-1b", "ap-south-1c"], count.index)
  tags = {
    Name = "${var.vpc_name}-publicSbnt-${count.index + 1}"
  }
}

resource "aws_subnet" "private" {
  count             = length(var.private_subnets)
  vpc_id           = aws_vpc.vpc.id
  cidr_block       = var.private_subnets[count.index]
  availability_zone = element(["ap-south-1a", "ap-south-1b", "ap-south-1c"], count.index)
  tags = {
    Name = "${var.vpc_name}-privateSbnt-${count.index + 1}"
  }
}

# 3. Create internat-gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.vpc_name}-igw"
  }
}

# 🚀 4. Create Public Route Table and Associate with Public Subnets
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.vpc_name}-public-rt"
  }
}

resource "aws_route" "public_internet" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# 🚀 5. NAT Gateway for Private Subnets
resource "aws_eip" "nat" {
  domain = "vpc"
  tags = {
    Name =  "${var.vpc_name}-nat-eip"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id
  tags = {
    Name = "${var.vpc_name}-nat-gateway"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.vpc_name}-private-rt"
  }
}

resource "aws_route" "private_nat" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
}

resource "aws_route_table_association" "private" {
  count          = length(var.private_subnets)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}
