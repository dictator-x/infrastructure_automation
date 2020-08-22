resource "aws_vpc" "vpc" {
  cidr_block = "10.7.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  instance_tenancy = "default"
  enable_classiclink = false
  tags = {
    Name = "vpc"
  }
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.7.0.0/20"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "public_subnet_1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.7.16.0/20"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "public_subnet_2"
  }
}

resource "aws_subnet" "public_subnet_3" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.7.32.0/20"
  availability_zone = "us-east-1c"
  map_public_ip_on_launch = true
  tags = {
    Name = "public_subnet_3"
  }
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.7.48.0/20"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = false
  tags = {
    Name = "private_subnet_1"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.7.64.0/20"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = false
  tags = {
    Name = "private_subnet_2"
  }
}

resource "aws_subnet" "private_subnet_3" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.7.80.0/20"
  availability_zone = "us-east-1c"
  map_public_ip_on_launch = false
  tags = {
    Name = "private_subnet_3"
  }
}


resource "aws_internet_gateway" "ig_gw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "ig_gw"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig_gw.id
  }
  tags = {
    Name = "public_route_table"
  }
}

resource "aws_default_route_table" "defualt_route_table" {
  default_route_table_id = aws_vpc.vpc.default_route_table_id
  tags = {
    Name = "defualt_route_table"
  }
}

resource "aws_route_table_association" "public_route_table_association_1" {
  subnet_id = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_route_table.id
}
resource "aws_route_table_association" "public_route_table_association_2" {
  subnet_id = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_route_table.id
}
resource "aws_route_table_association" "public_route_table_association_3" {
  subnet_id = aws_subnet.public_subnet_3.id
  route_table_id = aws_route_table.public_route_table.id
}

data "aws_vpc" "vpc" {
  id = aws_vpc.vpc.id
}
data "aws_subnet_ids" "all" {
  vpc_id = data.aws_vpc.vpc.id
}

data "aws_subnet_ids" "private" {
  vpc_id = data.aws_vpc.vpc.id
  filter {
    name = "tag:Name"
    values = [ "private*" ]
  }
}

data "aws_subnet_ids" "public" {
  vpc_id = data.aws_vpc.vpc.id
  filter {
    name = "tag:Name"
    values = [ "public*" ]
  }
}

output "aws_subnet_ids" {
  value = data.aws_subnet_ids.all.ids
}
output "aws_public_subnet_ids" {
  value = data.aws_subnet_ids.public.ids
}
output "aws_private_subnet_ids" {
  value = data.aws_subnet_ids.private.ids
}
