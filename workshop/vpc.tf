// vpc
resource "aws_vpc" "workshop" {

  cidr_block = "10.0.0.0/24"

  tags = {
    Name = "workshop-vpc"
    Ownedby = "Anuj"
    Createby = "terraform"

  }
}

// public subnets
resource "aws_subnet" "public_subnet_1" {
  cidr_block = "10.0.0.0/27"
  vpc_id = aws_vpc.workshop.id
  availability_zone = "us-east-1a"

  tags = {
    Name = "public-subnet-1"
    Ownedby = "Anuj"
    Createby = "terraform"
  }
}

// private subnets
resource "aws_subnet" "private_subnet_1" {
  cidr_block = "10.0.0.32/27"
  vpc_id = aws_vpc.workshop.id

  tags = {
    Name = "private-subnet-1"
    Ownedby = "Anuj"
    Createby = "terraform"
  }
}

// public route table
resource "aws_route_table" "public_route_table" {

  vpc_id = aws_vpc.workshop.id

  tags = {
    Name = "public-route-table"
    Ownedby = "Anuj"
    Createby = "terraform"
  }

}

// private route table
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.workshop.id


  tags = {
    Name = "private-route-table"
    Ownedby = "Anuj"
    Createby = "terraform"
  }

}

// route table association
resource "aws_route_table_association" "public_subnet_1_association" {
  route_table_id = aws_route_table.public_route_table.id
  subnet_id = aws_subnet.public_subnet_1.id
}

resource "aws_route_table_association" "public_subnet_2_association" {
  route_table_id = aws_route_table.private_route_table.id
  subnet_id = aws_subnet.private_subnet_1.id
}

// elasticip
resource "aws_eip" "elastic_ip_for_nat_gw" {
  vpc = true
  associate_with_private_ip = "10.0.0.5"

  tags = {
    Name = "eip-for-nat-gw"
    Ownedby = "Anuj"
    Createby = "terraform"
  }
}

// nat gateway (only egress for private subnets)
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.elastic_ip_for_nat_gw.id
  subnet_id = aws_subnet.public_subnet_1.id

  tags = {
    Name = "nat-gw-workshop"
    Ownedby = "Anuj"
    Createby = "terraform"
  }

  depends_on = [aws_eip.elastic_ip_for_nat_gw]
}


// associate nat to private route table
resource "aws_route" "nat_gw_route" {
  route_table_id = aws_route_table.private_route_table.id

  nat_gateway_id = aws_nat_gateway.nat_gw.id

  destination_cidr_block = "0.0.0.0/0"
}

// internet gateway (ingress and egress for public subnets)
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.workshop.id
  tags = {
    Name = "igw-workshop"
    Ownedby = "Anuj"
    Createby = "terraform"
  }
}

// associate igw to public route table
resource "aws_route" "igw_route" {
  route_table_id = aws_route_table.public_route_table.id
  gateway_id = aws_internet_gateway.igw.id
  destination_cidr_block = "0.0.0.0/0"
}