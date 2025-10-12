//creating a vpc

resource "aws_vpc" "myvpc" {
  cidr_block = var.myvpc
  enable_dns_support   = true
  enable_dns_hostnames = true
}

# Get available AZs
# -----------------------------
data "aws_availability_zones" "available" {}


# Defining a public subnets based on availability zones

resource "aws_subnet" "public_subnet" {
  count             = 3
  vpc_id            = aws_vpc.myvpc.id
  cidr_block        = cidrsubnet(aws_vpc.myvpc.cidr_block, 4, count.index + 1) # Example CIDR calculation
  availability_zone = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet-${count.index + 1}"
  }
}

# Defining a private subnets based on availability zones

resource "aws_subnet" "private_subnet" {
  count             = 3
  vpc_id            = aws_vpc.myvpc.id
  cidr_block        = cidrsubnet(aws_vpc.myvpc.cidr_block, 4, count.index + 4) # Example CIDR calculation
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = {
    Name = "private-subnet-${count.index + 1}"
  }
}

    
//creating internet gateway

resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.myvpc.id
}

//Defining NAT gateway

resource "aws_eip" "nat_eip" {
  count = 3
  domain = "vpc"
}

//Creating NAT gateway

resource "aws_nat_gateway" "main" {
  count         = 3
  allocation_id = aws_eip.nat_eip[count.index].id
  subnet_id     = aws_subnet.public_subnet[count.index].id
  tags = {
    Name = "nat-gateway-${count.index + 1}"
  }
}

//creating route tables

resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.myvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig.id
  }
}

//route association

resource "aws_route_table_association" "public_route" {
  count          = length(aws_subnet.public_subnet)
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_route.id
  
}

//Creating routing tables 

resource "aws_route_table" "private" {
  count  = 3
  vpc_id = aws_vpc.myvpc.id
  route {
	cidr_block = "10.0.0.0/16"
	nat_gateway_id = aws_nat_gateway.main[count.index].id
  }
  tags = {
	Name = "private-rt-${count.index + 1}"
  }
}


//Associating route tables 

resource "aws_route_table_association" "private" {
  count          = 3
  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}

//defining security groups

resource "aws_security_group" "web_sg" {
   name   = "HTTP and SSH"
   vpc_id = aws_vpc.myvpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
} 
