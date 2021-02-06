resource "aws_vpc" "main" {
  cidr_block           = "99.89.92.0/22"
  enable_dns_hostnames = true
  tags = {
    Name = "stage"
  }
}

resource "aws_subnet" "internal-01" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "99.89.92.128/25"
  map_public_ip_on_launch = false
  availability_zone       = "us-east-1a"
  tags = {
    Name = "internal-01-private"
  }
}

resource "aws_subnet" "internal-02" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "99.89.93.128/25"
  map_public_ip_on_launch = false
  availability_zone       = "us-east-1b"
  tags = {
    Name = "internal-02-private"
  }
}

resource "aws_subnet" "external-01" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "99.89.92.0/25"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
  tags = {
    Name = "external-01-public"
  }
}

resource "aws_subnet" "external-02" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "99.89.93.0/25"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"
  tags = {
    Name = "external-02-public"
  }
}

#igw
resource "aws_internet_gateway" "stage-internet-gw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "stage-internet-gw"
  }
}

resource "aws_route_table" "rt-table-public-ig" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.stage-internet-gw.id
  }
  tags = {
    Name = "rt-stage-external"
  }
}

resource "aws_route_table_association" "rt-external-01-association" {
  subnet_id      = aws_subnet.external-01.id
  route_table_id = aws_route_table.rt-table-public-ig.id
}

resource "aws_route_table_association" "rt-external-02-association" {
  subnet_id      = aws_subnet.external-02.id
  route_table_id = aws_route_table.rt-table-public-ig.id
}

#create eip - public ip is required to create nat gw - EIP once associated, owned by us
resource "aws_eip" "nat" {
  vpc = true
}

#create natgw
resource "aws_nat_gateway" "stage-nat-gw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.external-01.id
  depends_on    = [aws_internet_gateway.stage-internet-gw]
  tags = {
    Name = "stage-nat-gw"
  }
}


#route table for nat gateway and attach that to private subnet
resource "aws_route_table" "rt-stage-internal" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.stage-nat-gw.id
  }
  tags = {
    Name = "stage-nat-gw-route-table"
  }
}

resource "aws_route_table_association" "rt-internal-01-association" {
  subnet_id      = aws_subnet.internal-01.id
  route_table_id = aws_route_table.rt-stage-internal.id
}

resource "aws_route_table_association" "rt-internal-02-association" {
  subnet_id      = aws_subnet.internal-02.id
  route_table_id = aws_route_table.rt-stage-internal.id
}
