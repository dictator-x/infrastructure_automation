resource "aws_vpc" "my-vpc" {
  cidr_block = "10.7.0.0/16"
  enable_dns_support = false
  enable_dns_hostnames = false
  instance_tenancy = "default"
  enable_classiclink = false
  tags = {
    Name = "my-vpc"
  }
}

resource "aws_subnet" "my-vpc-public-1" {
  vpc_id = aws_vpc.my-vpc.id
  cidr_block = "10.7.0.0/20"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "my-vpc-public-1"
  }
}

resource "aws_subnet" "my-vpc-public-2" {
  vpc_id = aws_vpc.my-vpc.id
  cidr_block = "10.7.16.0/20"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "my-vpc-public-2"
  }
}

resource "aws_subnet" "my-vpc-public-3" {
  vpc_id = aws_vpc.my-vpc.id
  cidr_block = "10.7.32.0/20"
  availability_zone = "us-east-1c"
  map_public_ip_on_launch = true
  tags = {
    Name = "my-vpc-public-3"
  }
}

resource "aws_subnet" "my-vpc-private-1" {
  vpc_id = aws_vpc.my-vpc.id
  cidr_block = "10.7.48.0/20"
  availability_zone = "us-east-1d"
  map_public_ip_on_launch = false
  tags = {
    Name = "my-vpc-private-1"
  }
}

resource "aws_subnet" "my-vpc-private-2" {
  vpc_id = aws_vpc.my-vpc.id
  cidr_block = "10.7.64.0/20"
  availability_zone = "us-east-1e"
  map_public_ip_on_launch = false
  tags = {
    Name = "my-vpc-private-2"
  }
}

resource "aws_subnet" "my-vpc-private-3" {
  vpc_id = aws_vpc.my-vpc.id
  cidr_block = "10.7.80.0/20"
  availability_zone = "us-east-1f"
  map_public_ip_on_launch = false
  tags = {
    Name = "my-vpc-private-3"
  }
}


resource "aws_internet_gateway" "my-ig-gw" {
  vpc_id = aws_vpc.my-vpc.id
  tags = {
    Name = "my-ig-gw"
  }
}

resource "aws_route_table" "my-public-route-table" {
  vpc_id = aws_vpc.my-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-ig-gw.id
  }
  tags = {
    Name = "my-public-route"
  }
}

resource "aws_default_route_table" "my-default-route-table" {
  default_route_table_id = aws_vpc.my-vpc.default_route_table_id
  tags = {
    Name = "my-default-route"
  }
}

resource "aws_route_table_association" "my-public-subnet-1" {
  subnet_id = aws_subnet.my-vpc-public-1.id
  route_table_id = aws_route_table.my-public-route-table.id
}
resource "aws_route_table_association" "my-public-subnet-2" {
  subnet_id = aws_subnet.my-vpc-public-2.id
  route_table_id = aws_route_table.my-public-route-table.id
}
resource "aws_route_table_association" "my-public-subnet-3" {
  subnet_id = aws_subnet.my-vpc-public-3.id
  route_table_id = aws_route_table.my-public-route-table.id
}
