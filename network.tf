resource "aws_vpc" "test_2a" {
  cidr_block           = "192.168.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"
  tags = {
    Name = "wordpress"
  }
}

resource "aws_subnet" "public_2a" {
  cidr_block              = "192.168.10.0/24"
  vpc_id                  = "${aws_vpc.test_2a.id}"
  availability_zone       = "ap-northeast-2a"
  map_public_ip_on_launch = true
  tags = {
    Name = "public-2a"
  }
}

resource "aws_subnet" "public_2b" {
  cidr_block              = "192.168.20.0/24"
  vpc_id                  = "${aws_vpc.test_2a.id}"
  availability_zone       = "ap-northeast-2b"
  map_public_ip_on_launch = true
  tags = {
    Name = "public-2b"
  }
}

resource "aws_subnet" "public_2c" {
  cidr_block              = "192.168.30.0/24"
  vpc_id                  = "${aws_vpc.test_2a.id}"
  availability_zone       = "ap-northeast-2c"
  map_public_ip_on_launch = true
  tags = {
    Name = "public-2c"
  }
}

resource "aws_subnet" "priv_2a" {
  cidr_block              = "192.168.40.0/24"
  vpc_id                  = "${aws_vpc.test_2a.id}"
  availability_zone       = "ap-northeast-2a"
  map_public_ip_on_launch = false
  tags = {
    Name = "priv-2a"
  }
}

resource "aws_subnet" "priv_2b" {
  cidr_block              = "192.168.50.0/24"
  vpc_id                  = "${aws_vpc.test_2a.id}"
  availability_zone       = "ap-northeast-2b"
  map_public_ip_on_launch = false
  tags = {
    Name = "priv-2b"
  }
}

resource "aws_subnet" "priv_2c" {
  cidr_block              = "192.168.60.0/24"
  vpc_id                  = "${aws_vpc.test_2a.id}"
  availability_zone       = "ap-northeast-2c"
  map_public_ip_on_launch = false
  tags = {
    Name = "priv-2c"
  }
}

resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.test_2a.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.internet-gw.id}"
  }
  tags = {
    Name = "route-public"
  }
}

resource "aws_route_table" "private" {
  vpc_id = "${aws_vpc.test_2a.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_nat_gateway.nat-gw.id}"
  }
  tags = {
    Name = "route-private"
  }
}

resource "aws_route_table_association" "priv1" {
  subnet_id      = "${aws_subnet.priv_2b.id}"
  route_table_id = "${aws_route_table.private.id}"
}

resource "aws_route_table_association" "priv2" {
  subnet_id      = "${aws_subnet.priv_2b.id}"
  route_table_id = "${aws_route_table.private.id}"
}

resource "aws_route_table_association" "priv3" {
  subnet_id      = "${aws_subnet.priv_2c.id}"
  route_table_id = "${aws_route_table.private.id}"
}

resource "aws_route_table_association" "public1" {
  subnet_id      = "${aws_subnet.public_2a.id}"
  route_table_id = "${aws_route_table.public.id}"
}

resource "aws_route_table_association" "public2" {
  subnet_id      = "${aws_subnet.public_2b.id}"
  route_table_id = "${aws_route_table.public.id}"
}

resource "aws_route_table_association" "public3" {
  subnet_id      = "${aws_subnet.public_2c.id}"
  route_table_id = "${aws_route_table.public.id}"
}

resource "aws_internet_gateway" "internet-gw" {
  vpc_id = "${aws_vpc.test_2a.id}"
}

resource "aws_nat_gateway" "nat-gw" {
  allocation_id = "${aws_eip.nat1.id}"
  subnet_id     = "${aws_subnet.public_2a.id}"
  tags = {
    Name = "nat-gw1"
  }
}

resource "aws_eip" "nat1" {
  vpc              = true
  public_ipv4_pool = "amazon"
  tags = {
    Name = "nat1"
  }
}

