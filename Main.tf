resource "aws_vpc" "rakesh" {
  cidr_block                     = "10.0.0.0/16"
  instance_tenancy               = "default"
  enable_dns_support             = true
  enable_dns_hostnames           = true

  tags = {
    Name = "rakesh_vpc"
  }

}

resource "aws_subnet" "rakesh1" {
  vpc_id                  = aws_vpc.rakesh.id
  cidr_block              = "10.0.8.0/22"
  map_public_ip_on_launch = true
  availability_zone       = "ap-south-1a"

  tags = {
    Name = "public"
  }


}

resource "aws_internet_gateway" "first" {
  vpc_id = aws_vpc.rakesh.id

  tags = {
    Name = "int-gat"
  }


}

resource "aws_route_table" "first" {
  vpc_id = aws_vpc.rakesh.id

  tags = {
    Name = "Rakesh"
  }

}
resource "aws_route" "default-rtl" {
  route_table_id         = aws_route_table.first.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.first.id

}

resource "aws_route_table_association" "noth" {
  subnet_id      = aws_subnet.rakesh1.id
  route_table_id = aws_route_table.first.id

}

resource "aws_security_group" "manage_sg" {
  name        = "allow TCP"
  description = "Allow TCP inbouns traffic"
  vpc_id      = aws_vpc.rakesh.id


  ingress {
    from_port  = 0
    to_port    = 0
    protocol   = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {
    from_port  = 0
    to_port    = 0
    protocol   = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name =  "rakesh-sg"
  }


}