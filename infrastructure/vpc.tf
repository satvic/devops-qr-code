# VPC Configurations
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  # To connect to the internet
  enable_dns_hostnames = true
}

resource "aws_subnet" "subnet1" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.0.0/20"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "subnet2" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.16.0/20"
  availability_zone = "us-east-1c"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "subnet3" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.32.0/20"
  availability_zone = "us-east-1d"
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

    route {
    cidr_block = "10.0.0.0/16"
    gateway_id = "local"
  }
}

resource "aws_route_table_association" "subnet_1_association" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_route_table_association" "subnet_2_association" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_route_table_association" "subnet_3_association" {
  subnet_id      = aws_subnet.subnet3.id
  route_table_id = aws_route_table.route_table.id
}