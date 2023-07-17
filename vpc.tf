resource "aws_vpc" "Jenvpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"

  tags = {
    Name = "Jenkins-VPC"
  }
}

resource "aws_subnet" "sub1" {
  vpc_id                  = aws_vpc.Jenvpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE1

  tags = {
    Name = "Public Sub1"
  }
}

resource "aws_subnet" "sub2" {
  vpc_id                  = aws_vpc.Jenvpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE1

  tags = {
    Name = "Private Sub1"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.Jenvpc.id

  tags = {
    Name = "IGW"
  }
}

resource "aws_route_table" "RT" {
  vpc_id = aws_vpc.Jenvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "Route Table"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.sub1.id
  route_table_id = aws_route_table.RT.id
}