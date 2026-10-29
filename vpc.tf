terraform {
  required_providers {
    aws={
        source = "hashicorp/aws"
        version = "~> 6.0"
    }
  }
}

provider "aws" {
    region = "ap-southeast-2"
  
}

resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name="lab-vpc"
    }
 
}

resource "aws_subnet" "public" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "ap-southeast-2a"
    map_public_ip_on_launch = true

    tags = {
        Name="lab-public-subnet"
    }

  
}
resource "aws_subnet" "private" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "ap-southeast-2a"

    tags = {
        Name="lab-private-subnet"
    }

  
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main.id

    tags = {
        Name="lab-igw"
    }

  
}


resource "aws_route_table" "public" {
    vpc_id = aws_vpc.main.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
    tags = {
        Name="lab-public-rt"
  
    }
}

resource "aws_route_table" "private" {
    vpc_id = aws_vpc.main.id
    tags = {
        Name="lab-private-rt"
    }


}

resource "aws_route_table_association" "public" {
    subnet_id = aws_subnet.public.id
    route_table_id = aws_route_table.public.id
  
}
resource "aws_route_table_association" "private" {
    subnet_id = aws_subnet.private.id
    route_table_id = aws_route_table.private.id
  
}

resource "aws_security_group" "web" {
    vpc_id = aws_vpc.main.id
    name = "lab-web-sg"

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]

    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]

    }
  
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]

    }
     tags = {
       Name="lab-web-sg"
     }
  
}

resource "aws_instance" "example" {
    ami = "ami-0dd60a46ecc6eac16"
    instance_type = "t3.micro"
    subnet_id = aws_subnet.public.id
    vpc_security_group_ids = [aws_security_group.web.id]

    tags = {
      Name="lab-pubic-ec2"
    }
  
}
