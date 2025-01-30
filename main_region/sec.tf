### VPC ###
resource "aws_vpc" "demo_vpc_sec" {
    provider = aws.apse2
    cidr_block = var.vpc_cidr_sec
    tags = {
        Name = "CAMPF_VPC_Secondary"
    }
}

# ### IGW ###
resource "aws_internet_gateway" "igw_sec" {
    provider = aws.apse2
    vpc_id = aws_vpc.demo_vpc_sec.id
    tags = {
        Name = "Internet Gateway"
    }
}

# ### NAT Gateway ###
resource "aws_eip" "nat_gateway_ip_sec" {
    provider = aws.apse2
    domain = "vpc"
}

resource "aws_nat_gateway" "nat_gateway_sec" {
  provider = aws.apse2
  allocation_id = aws_eip.nat_gateway_ip_sec.id
  subnet_id = aws_subnet.pub_1_sec.id
  depends_on = [aws_internet_gateway.igw_sec]
  tags = {
      Name = "NAT Gateway Sec"
  }
}

### VPC Subnets ###
resource "aws_subnet" "pub_1_sec" {
  provider = aws.apse2
  vpc_id = aws_vpc.demo_vpc_sec.id
  cidr_block = var.pub_1_sec_subnet_cidr_block
  availability_zone = var.pub_1_subnet_az_sec

  tags = {
      Name = "Pub_1"
  }
}

resource "aws_subnet" "pub_2_sec" {
  provider = aws.apse2
  vpc_id = aws_vpc.demo_vpc_sec.id
  cidr_block = var.pub_2_sec_subnet_cidr_block
  availability_zone = var.pub_2_subnet_az_sec

  tags = {
      Name = "Pub_2"
  }
}

resource "aws_subnet" "pub_3_sec" {
  provider = aws.apse2
  vpc_id = aws_vpc.demo_vpc_sec.id
  cidr_block = var.pub_3_sec_subnet_cidr_block
  availability_zone = var.pub_3_subnet_az_sec

  tags = {
      Name = "Pub_3"
  }
}

resource "aws_subnet" "pri_1_sec" {
  provider = aws.apse2
  vpc_id = aws_vpc.demo_vpc_sec.id
  cidr_block = var.pri_1_sec_subnet_cidr_block
  availability_zone = var.pri_1_subnet_az_sec

  tags = {
      Name = "Pri_1"
  }
}

resource "aws_subnet" "pri_2_sec" {
  provider = aws.apse2
  vpc_id = aws_vpc.demo_vpc_sec.id
  cidr_block = var.pri_2_sec_subnet_cidr_block
  availability_zone = var.pri_2_subnet_az_sec

  tags = {
      Name = "Pri_2"
  }
}

resource "aws_subnet" "pri_3_sec" {
  provider = aws.apse2
  vpc_id = aws_vpc.demo_vpc_sec.id
  cidr_block = var.pri_3_sec_subnet_cidr_block
  availability_zone = var.pri_3_subnet_az_sec

  tags = {
      Name = "Pri_3"
  }
}

### Route Tables ###
resource "aws_route_table" "public_route_table_sec" {
    provider = aws.apse2
    vpc_id = aws_vpc.demo_vpc_sec.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw_sec.id
    }
    tags = {
        Name = "Public Route Table"
    }
}

resource "aws_route_table" "private_route_table_sec" {
    provider = aws.apse2
    vpc_id = aws_vpc.demo_vpc_sec.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.nat_gateway_sec.id
    }
    tags = {
        Name = "Private Route Table"
    }
}

resource "aws_route_table_association" "pub_1_sec" {
    provider = aws.apse2
    subnet_id = aws_subnet.pub_1_sec.id
    route_table_id = aws_route_table.public_route_table_sec.id
}

resource "aws_route_table_association" "pub_2_sec" {
    provider = aws.apse2
    subnet_id = aws_subnet.pub_2_sec.id
    route_table_id = aws_route_table.public_route_table_sec.id
}

resource "aws_route_table_association" "pub_3_sec" {
    provider = aws.apse2
    subnet_id = aws_subnet.pub_3_sec.id
    route_table_id = aws_route_table.public_route_table_sec.id
}

resource "aws_route_table_association" "pri_1_sec" {
    provider = aws.apse2
    subnet_id = aws_subnet.pri_1_sec.id
    route_table_id = aws_route_table.private_route_table_sec.id
}

resource "aws_route_table_association" "pri_2_sec" {
    provider = aws.apse2
    subnet_id = aws_subnet.pri_2_sec.id
    route_table_id = aws_route_table.private_route_table_sec.id
}

resource "aws_route_table_association" "pri_3_sec" {
    provider = aws.apse2
    subnet_id = aws_subnet.pri_3_sec.id
    route_table_id = aws_route_table.private_route_table_sec.id
}

### NACL for Public Subnets ###
resource "aws_network_acl" "nacl_public_sec" {
    provider = aws.apse2
    vpc_id = aws_vpc.demo_vpc_sec.id
    subnet_ids = [aws_subnet.pub_1_sec.id, aws_subnet.pub_2_sec.id, aws_subnet.pub_3_sec.id]

    egress {
            protocol = "-1"
            rule_no = 200
            action = "allow"
            cidr_block = "0.0.0.0/0"
            from_port = 0
            to_port = 0
        }

    ingress {
            protocol = "tcp"
            rule_no = 100
            action = "allow"
            cidr_block = "0.0.0.0/0"
            from_port = 1024
            to_port = 65535
        }

    ingress {
            protocol = "tcp"
            rule_no = 300
            action = "allow"
            cidr_block = "0.0.0.0/0"
            from_port = 80
            to_port = 80
        }

    ingress {
            protocol = "tcp"
            rule_no = 500
            action = "allow"
            cidr_block = "0.0.0.0/0"
            from_port = 443
            to_port = 443
        }

    tags = {
        Name = "Public NACL"
    }
}

### NACL for Private Subnets ###
resource "aws_network_acl" "nacl_private_sec" {
    provider = aws.apse2
    vpc_id = aws_vpc.demo_vpc_sec.id
    subnet_ids = [aws_subnet.pri_1_sec.id, aws_subnet.pri_2_sec.id, aws_subnet.pri_3_sec.id]

    egress{
            protocol = "-1"
            rule_no = 200
            action = "allow"
            cidr_block = "0.0.0.0/0"
            from_port = 0
            to_port = 0
        }

    ingress {
            protocol = "tcp"
            rule_no = 100
            action = "allow"
            cidr_block = "0.0.0.0/0"
            from_port = 1024
            to_port = 65535
        }

    ingress {
            protocol = "tcp"
            rule_no = 300
            action = "allow"
            cidr_block = "0.0.0.0/0"
            from_port = 80
            to_port = 80
        }

    ingress {
            protocol = "tcp"
            rule_no = 500
            action = "allow"
            cidr_block = "0.0.0.0/0"
            from_port = 443
            to_port = 443
        }

    tags = {
        Name = "Private NACL"
    }
}

resource "aws_route" "sec_to_staging" {
  provider = aws.apse2
  route_table_id            = aws_route_table.private_route_table_sec.id
  destination_cidr_block    = var.vpc_cidr_staging
  vpc_peering_connection_id = aws_vpc_peering_connection.staging_to_sec.id
}