provider "aws" {
  region = "us-east-1"
}

data "aws_route_tables" "aws-ALD-route-table" {
  vpc_id = var.vpc_id

}


resource "aws_route" "route" {
  route_table_id = data.aws_route_tables.aws-ALD-route-table.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_vpc" "aws-ALD-vpc" {
  cidr_block = "10.0.0.0/16"
  instance_tenancy = "dedicated"


  tags = {
    Name = "aws-ALD-vpc",
    Owner = "Pravar",
    Role = "POC"
  }
}



resource "aws_subnet" "public-ALD-az1" {

  vpc_id = var.vpc_id
  cidr_block = "10.0.0.0/24"



  tags = {
    Name = "public-ALD-az1",
    Owner = "Pravar",
    Role = "POC"
  }
}


resource "aws_subnet" "private-ALD-az2" {
  vpc_id = aws_vpc.aws-ALD-vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "private-ALD-az2",
    Owner = "Pravar",
    Role = "POC"
  }
}


    
