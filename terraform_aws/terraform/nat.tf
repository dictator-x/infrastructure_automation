resource "aws_eip" "my-eip" {
  vpc = true
  tags = {
    Name = "my-eip"
  }
}

resource "aws_nat_gateway" "my-nat-gw" {
  allocation_id = aws_eip.my-eip.id
  subnet_id = aws_subnet.my-vpc-public-1.id
  depends_on = [aws_internet_gateway.my-ig-gw]
  tags = {
    Name = "my-nat-gw"
  }
}

resource "aws_route_table" "my-private-route-table" {
  vpc_id = aws_vpc.my-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.my-nat-gw.id
  }
  tags = {
    Name = "my-private-route"
  }
}


resource "aws_route_table_association" "my-private-subnet-1" {
  subnet_id = aws_subnet.my-vpc-private-1.id
  route_table_id = aws_route_table.my-private-route-table.id
}
resource "aws_route_table_association" "my-private-subnet-2" {
  subnet_id = aws_subnet.my-vpc-private-2.id
  route_table_id = aws_route_table.my-private-route-table.id
}
resource "aws_route_table_association" "my-private-subnet-3" {
  subnet_id = aws_subnet.my-vpc-private-3.id
  route_table_id = aws_route_table.my-private-route-table.id
}
