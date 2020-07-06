provider "aws" {
  region = "us-east-1"
}


resource "aws_vpc" "aws-ALD-vpc" {
  cidr_block = var.vpcCIDRblock
  instance_tenancy = "default"
  enable_dns_support = var.dnsSupport
  enable_dns_hostnames = var.dnsHostNames


  tags = {
    Name = "aws-ALD-vpc",
    Owner = "Pravar",
    Role = "POC"
  }
}



resource "aws_subnet" "public-ALD-subnet" {

  vpc_id = aws_vpc.aws-ALD-vpc.id
  cidr_block = var.subnetPublicCIDRblock
  map_public_ip_on_launch = var.mapPublicIP
  availability_zone = var.availabilityZone


  tags = {
    Name = "public-ALD-subnet",
    Owner = "Pravar",
    Role = "POC"
  }
}


resource "aws_subnet" "private-ALD-subnet" {
  vpc_id = aws_vpc.aws-ALD-vpc.id
  cidr_block = var.subnetPrivateCIDRblock
  availability_zone = var.availabilityZone

  tags = {
    Name = "private-ALD-az2",
    Owner = "Pravar",
    Role = "POC"
  }
}


# security group
resource "aws_security_group" "ALD_VPC_Security_Group" {
  vpc_id = aws_vpc.aws-ALD-vpc.id
  name = "ALD VPC Security Group"

  # allow ingress of port 22
  ingress {
    cidr_blocks = var.ingressCIDRblock
    from_port = 22
    to_port = 22
    protocol = "tcp"
  }

  # allow egress of all ports
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ALD_VPC_Security_group"
    Owner = "Pravar"
    Role = "POC"
  }
}


# create VPC Network access control list
resource "aws_network_acl" "ALD_VPC_Security_ACL" {
  vpc_id = aws_vpc.aws-ALD-vpc.id
  subnet_ids = [ aws_subnet.public_ALD_subnet.id, aws_subnet.private_ALD_subnet.id ]
  
# allow ingress port 22
  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = var.destinationCIDRblock 
    from_port  = 22
    to_port    = 22
  }
  
  # allow ingress port 80 
  ingress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = var.destinationCIDRblock 
    from_port  = 80
    to_port    = 80
  }
  
  # allow ingress ephemeral ports 
  ingress {
    protocol   = "tcp"
    rule_no    = 300
    action     = "allow"
    cidr_block = var.destinationCIDRblock
    from_port  = 1024
    to_port    = 65535
  }
  
  # allow egress port 22 
  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = var.destinationCIDRblock
    from_port  = 22 
    to_port    = 22
  }
  
  # allow egress port 80 
  egress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = var.destinationCIDRblock
    from_port  = 80  
    to_port    = 80 
  }
 
  # allow egress ephemeral ports
  egress {
    protocol   = "tcp"
    rule_no    = 300
    action     = "allow"
    cidr_block = var.destinationCIDRblock
    from_port  = 1024
    to_port    = 65535
  }
tags = {
  Name = "ALD VPC ACL",
  Owner = "Pravar",
  Role = "POC"
}
}

# Create the Internet Gateway
resource "aws_internet_gateway" "ALD_VPC_GW" {
 vpc_id = aws_vpc.aws-ALD-vpc.id
 tags = {
   Name = "ALD VPC Internet Gateway",
   Owner = "Pravar",
   Role = "POC"
}
}

# Create the Route Table
resource "aws_route_table" "ALD_VPC_route_table" {
 vpc_id = aws_vpc.aws-ALD-vpc.id
 tags = {
   Name = "ALD VPC Route Table",
   Owner = "Pravar",
   Role = "POC"
}
}

# Create the Internet Access
resource "aws_route" "My_VPC_internet_access" {
  route_table_id         = aws_route_table.ALD_VPC_route_table.id
  destination_cidr_block = var.destinationCIDRblock
  gateway_id             = aws_internet_gateway.ALD_VPC_GW.id
} # end resource

# Associate the Route Table with the Subnet
resource "aws_route_table_association" "My_VPC_association" {
  subnet_id      = aws_subnet.public-ALD-subnet.id
  route_table_id = aws_route_table.ALD_VPC_route_table.id
}
