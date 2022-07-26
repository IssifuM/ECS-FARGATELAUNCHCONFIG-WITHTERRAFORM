#describes our VPC with a 2 public subnet and 2 private subnets 
#each subnet are in each AZ ie. 2a & 2b. thus public subnet 1 is in AZ 2a and publics subnet 2 is in AZ 2b. Same goes for the  Private subnet. 
#this will help the The DB subnet group to meet Availability Zone (AZ) coverage requirement
# And A load balancer cannot be attached to multiple subnets in the same Availability Zone so spreading the public subnets in different AZ will help meet this requirement.
# Internet Gateway to contact the outer world
#Security groups for RDS MySQL and for EC2s
#Auto-scaling group for ECS cluster with launch configuration
# RDS MySQL instance



# creating aws networking for a project

resource "aws_vpc" "Prod_rock_VPC" {
  cidr_block           = var.vpc-cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "rock_vpc"
  }
}

# creating public subnet

resource "aws_subnet" "Test-public-sub1" {
  vpc_id            = aws_vpc.Prod_rock_VPC.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = var.az1

  tags = {
    Name = "rock_public_subnet"
  }
}

# creating public subnet 2

resource "aws_subnet" "test-public-sub2" {
  vpc_id            = aws_vpc.Prod_rock_VPC.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = var.az2

  tags = {
    Name = "rock_public_subnet"
  }
}


# creating private subnet 

resource "aws_subnet" "Test-priv-sub1" {
  vpc_id            = aws_vpc.Prod_rock_VPC.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = var.az1

  tags = {
    Name = "rock_private_subnet"
  }
}

# creating private subnet 2

resource "aws_subnet" "Test-priv-sub2" {
  vpc_id            = aws_vpc.Prod_rock_VPC.id
  cidr_block        = "10.0.5.0/24"
  availability_zone = var.az2

  tags = {
    Name = "rock_private_subnet"
  }
}

# public route table

resource "aws_route_table" "Test-pub-route-table" {
  vpc_id = aws_vpc.Prod_rock_VPC.id


  route = []

  tags = {
    Name = "Rock-public-route-table"
  }
}

# private route table

resource "aws_route_table" "Test-priv-route-table" {
  vpc_id = aws_vpc.Prod_rock_VPC.id


  route = []

  tags = {
    Name = "Rock-private-route-table"
  }
}


# associate Public subnet 1 with Public route table

resource "aws_route_table_association" "prod-pub-route-association1" {
  subnet_id      = aws_subnet.Test-public-sub1.id
  route_table_id = aws_route_table.Test-pub-route-table.id
}

# associate Public subnet 2 with Public route table

resource "aws_route_table_association" "prod-pub-route-association2" {
  subnet_id      = aws_subnet.test-public-sub2.id
  route_table_id = aws_route_table.Test-pub-route-table.id
}


# associate Private subnet 1 with Private route table

resource "aws_route_table_association" "prod-priv-route-association1" {
  subnet_id      = aws_subnet.Test-priv-sub1.id
  route_table_id = aws_route_table.Test-priv-route-table.id
}

# associate Private subnet 2 with Private route table

resource "aws_route_table_association" "prod-priv-route-association2" {
  subnet_id      = aws_subnet.Test-priv-sub2.id
  route_table_id = aws_route_table.Test-priv-route-table.id
}


resource "aws_internet_gateway" "Test-igw" {
  vpc_id = aws_vpc.Prod_rock_VPC.id

  tags = {
    Name = "Rock_IGW"
  }
}

# associate internet gateway to public route table

resource "aws_route" "Test-igw-association" {
  route_table_id         = aws_route_table.Test-pub-route-table.id
  gateway_id             = aws_internet_gateway.Test-igw.id
  destination_cidr_block = "0.0.0.0/0"
}

#create Elastic IP

resource "aws_eip" "Prod-EIP" {
  vpc = true
}

#Creating NAT gateway.

resource "aws_nat_gateway" "Test-Nat-gateway" {
  allocation_id = aws_eip.Prod-EIP.id
  subnet_id     = aws_subnet.Test-public-sub1.id

  tags = {
    Name = "Prod-Nat-gateway"
  }
}

#Associating NATgateway with private route table

resource "aws_route" "test-Nat-association" {
  route_table_id         = aws_route_table.Test-priv-route-table.id
  nat_gateway_id         = aws_nat_gateway.Test-Nat-gateway.id
  destination_cidr_block = "0.0.0.0/0"
}