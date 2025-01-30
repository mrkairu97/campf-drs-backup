### VPC ###
resource "aws_vpc" "demo_vpc_staging" {
  provider             = aws.apse2
  cidr_block           = var.vpc_cidr_staging
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "CAMPF_VPC_Staging"
  }
}

# ### IGW ###
# resource "aws_internet_gateway" "igw_staging" {
#     provider = aws.apse2
#     vpc_id = aws_vpc.demo_vpc_staging.id
#     tags = {
#         Name = "Internet Gateway"
#     }
# }

# ### NAT Gateway ###
# resource "aws_eip" "nat_gateway_ip_staging" {
#     provider = aws.apse2
#     domain = "vpc"
# }

# resource "aws_nat_gateway" "nat_gateway_staging" {
#   provider = aws.apse2
#   allocation_id = aws_eip.nat_gateway_ip_staging.id
#   subnet_id = aws_subnet.pub_1_staging.id
#   depends_on = [aws_internet_gateway.igw_staging]
#   tags = {
#       Name = "NAT Gateway Sec"
#   }
# }

### VPC Subnets ###
# resource "aws_subnet" "pub_1_staging" {
#   provider = aws.apse2
#   vpc_id = aws_vpc.demo_vpc_staging.id
#   cidr_block = var.pub_1_staging_subnet_cidr_block
#   availability_zone = var.pub_1_subnet_az_staging

#   tags = {
#       Name = "Pub_1"
#   }
# }

# resource "aws_subnet" "pub_2_staging" {
#   provider = aws.apse2
#   vpc_id = aws_vpc.demo_vpc_staging.id
#   cidr_block = var.pub_2_staging_subnet_cidr_block
#   availability_zone = var.pub_2_subnet_az_staging

#   tags = {
#       Name = "Pub_2"
#   }
# }

# resource "aws_subnet" "pub_3_staging" {
#   provider = aws.apse2
#   vpc_id = aws_vpc.demo_vpc_staging.id
#   cidr_block = var.pub_3_staging_subnet_cidr_block
#   availability_zone = var.pub_3_subnet_az_staging

#   tags = {
#       Name = "Pub_3"
#   }
# }

resource "aws_subnet" "pri_1_staging" {
  provider          = aws.apse2
  vpc_id            = aws_vpc.demo_vpc_staging.id
  cidr_block        = var.pri_1_staging_subnet_cidr_block
  availability_zone = var.pri_1_subnet_az_staging

  tags = {
    Name = "Pri_1"
  }
}

resource "aws_subnet" "pri_2_staging" {
  provider          = aws.apse2
  vpc_id            = aws_vpc.demo_vpc_staging.id
  cidr_block        = var.pri_2_staging_subnet_cidr_block
  availability_zone = var.pri_2_subnet_az_staging

  tags = {
    Name = "Pri_2"
  }
}

resource "aws_subnet" "pri_3_staging" {
  provider          = aws.apse2
  vpc_id            = aws_vpc.demo_vpc_staging.id
  cidr_block        = var.pri_3_staging_subnet_cidr_block
  availability_zone = var.pri_3_subnet_az_staging

  tags = {
    Name = "Pri_3"
  }
}

### Route Tables ###
# resource "aws_route_table" "public_route_table_staging" {
#     provider = aws.apse2
#     vpc_id = aws_vpc.demo_vpc_staging.id
#     route {
#         cidr_block = "0.0.0.0/0"
#         gateway_id = aws_internet_gateway.igw_staging.id
#     }
#     tags = {
#         Name = "Public Route Table"
#     }
# }

resource "aws_route_table" "private_route_table_staging" {
  provider = aws.apse2
  vpc_id   = aws_vpc.demo_vpc_staging.id
  # route {
  #     cidr_block = "0.0.0.0/0"
  #     gateway_id = aws_nat_gateway.nat_gateway_staging.id
  # }
  tags = {
    Name = "Private Route Table"
  }
}

# resource "aws_route_table_association" "pub_1_staging" {
#     provider = aws.apse2
#     subnet_id = aws_subnet.pub_1_staging.id
#     route_table_id = aws_route_table.public_route_table_staging.id
# }

# resource "aws_route_table_association" "pub_2_staging" {
#     provider = aws.apse2
#     subnet_id = aws_subnet.pub_2_staging.id
#     route_table_id = aws_route_table.public_route_table_staging.id
# }

# resource "aws_route_table_association" "pub_3_staging" {
#     provider = aws.apse2
#     subnet_id = aws_subnet.pub_3_staging.id
#     route_table_id = aws_route_table.public_route_table_staging.id
# }

resource "aws_route_table_association" "pri_1_staging" {
  provider       = aws.apse2
  subnet_id      = aws_subnet.pri_1_staging.id
  route_table_id = aws_route_table.private_route_table_staging.id
}

resource "aws_route_table_association" "pri_2_staging" {
  provider       = aws.apse2
  subnet_id      = aws_subnet.pri_2_staging.id
  route_table_id = aws_route_table.private_route_table_staging.id
}

resource "aws_route_table_association" "pri_3_staging" {
  provider       = aws.apse2
  subnet_id      = aws_subnet.pri_3_staging.id
  route_table_id = aws_route_table.private_route_table_staging.id
}


### NACL for Public Subnets ###
# resource "aws_network_acl" "nacl_public_staging" {
#     provider = aws.apse2
#     vpc_id = aws_vpc.demo_vpc_staging.id
#     subnet_ids = [aws_subnet.pub_1_staging.id, aws_subnet.pub_2_staging.id, aws_subnet.pub_3_staging.id]

#     egress {
#             protocol = "-1"
#             rule_no = 200
#             action = "allow"
#             cidr_block = "0.0.0.0/0"
#             from_port = 0
#             to_port = 0
#         }

#     ingress {
#             protocol = "tcp"
#             rule_no = 100
#             action = "allow"
#             cidr_block = "0.0.0.0/0"
#             from_port = 1024
#             to_port = 65535
#         }

#     ingress {
#             protocol = "tcp"
#             rule_no = 300
#             action = "allow"
#             cidr_block = "0.0.0.0/0"
#             from_port = 80
#             to_port = 80
#         }

#     ingress {
#             protocol = "tcp"
#             rule_no = 500
#             action = "allow"
#             cidr_block = "0.0.0.0/0"
#             from_port = 443
#             to_port = 443
#         }

#     tags = {
#         Name = "Public NACL"
#     }
# }

### NACL for Private Subnets ###
resource "aws_network_acl" "nacl_private_staging" {
  provider   = aws.apse2
  vpc_id     = aws_vpc.demo_vpc_staging.id
  subnet_ids = [aws_subnet.pri_1_staging.id, aws_subnet.pri_2_staging.id, aws_subnet.pri_3_staging.id]

  egress {
    protocol   = "-1"
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1024
    to_port    = 65535
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 300
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 500
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 443
    to_port    = 443
  }

  tags = {
    Name = "Private NACL"
  }
}

resource "aws_route" "staging_to_main" {
  provider                  = aws.apse2
  route_table_id            = aws_route_table.private_route_table_staging.id
  destination_cidr_block    = var.vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.main_to_staging.id
}

resource "aws_vpc_peering_connection" "staging_to_sec" {
  provider    = aws.apse2
  vpc_id      = aws_vpc.demo_vpc_staging.id
  peer_vpc_id = aws_vpc.demo_vpc_sec.id
  auto_accept = true # Auto accept since same AWS account
}

resource "aws_route" "staging_to_sec_1" {
  provider                  = aws.apse2
  route_table_id            = aws_route_table.private_route_table_staging.id
  destination_cidr_block    = var.pri_1_sec_subnet_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.staging_to_sec.id
}

resource "aws_route" "staging_to_sec_2" {
  provider                  = aws.apse2
  route_table_id            = aws_route_table.private_route_table_staging.id
  destination_cidr_block    = var.pri_2_sec_subnet_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.staging_to_sec.id
}

resource "aws_route" "staging_to_sec_3" {
  provider                  = aws.apse2
  route_table_id            = aws_route_table.private_route_table_staging.id
  destination_cidr_block    = var.pri_3_sec_subnet_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.staging_to_sec.id
}


# # # Accepter's side of the connection.
resource "aws_vpc_peering_connection_accepter" "main_to_staging" {
  provider                  = aws.apse2
  vpc_peering_connection_id = aws_vpc_peering_connection.main_to_staging.id
  auto_accept               = true

  tags = {
    Side = "Accepter"
  }
}

resource "aws_security_group" "drs_endpoint_sg" {
  provider    = aws.apse2
  name        = "drs-endpoint-sg"
  description = "Security group for DRS VPC endpoint"
  vpc_id      = aws_vpc.demo_vpc_staging.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Adjust based on your VPC CIDR
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "ec2_endpoint_sg" {
  provider    = aws.apse2
  name        = "ec2-endpoint-sg"
  description = "Security group for EC2 VPC endpoint"
  vpc_id      = aws_vpc.demo_vpc_staging.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Adjust based on your VPC CIDR
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "s3_interface_sg" {
  provider = aws.apse2
  vpc_id = aws_vpc.demo_vpc_staging.id
  name   = "s3-interface-endpoint-sg"

  # Allow HTTPS traffic to S3
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Adjust based on your security needs
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "S3 Interface Endpoint SG"
  }
}


resource "aws_vpc_endpoint" "drs" {
  provider          = aws.apse2
  vpc_id            = aws_vpc.demo_vpc_staging.id
  service_name      = "com.amazonaws.${var.vpc_region_staging}.drs"
  vpc_endpoint_type = "Interface"
  subnet_ids        = [aws_subnet.pri_1_staging.id, aws_subnet.pri_2_staging.id, aws_subnet.pri_3_staging.id]

  security_group_ids = [aws_security_group.drs_endpoint_sg.id]

  private_dns_enabled = true

  tags = {
    Name = "DRS Interface Endpoint"
  }
}

resource "aws_vpc_endpoint" "ec2" {
  provider          = aws.apse2
  vpc_id            = aws_vpc.demo_vpc_staging.id
  service_name      = "com.amazonaws.${var.vpc_region_staging}.ec2"
  vpc_endpoint_type = "Interface"
  subnet_ids        = [aws_subnet.pri_1_staging.id, aws_subnet.pri_2_staging.id, aws_subnet.pri_3_staging.id]
  security_group_ids = [aws_security_group.ec2_endpoint_sg.id]
  private_dns_enabled = true

  tags = {
    Name = "EC2 Interface Endpoint"
  }
}

resource "aws_vpc_endpoint" "s3_interface" {
  provider = aws.apse2
  vpc_id            = aws_vpc.demo_vpc_staging.id
  service_name      = "com.amazonaws.${var.vpc_region_staging}.s3"
  vpc_endpoint_type = "Interface"
  subnet_ids        = [aws_subnet.pri_1_staging.id, aws_subnet.pri_2_staging.id, aws_subnet.pri_3_staging.id]
  security_group_ids = [aws_security_group.s3_interface_sg.id]
  private_dns_enabled = true

  tags = {
    Name = "S3 Interface Endpoint"
  }
}

resource "aws_vpc_endpoint" "ssm_interface" {
  provider = aws.apse2
  vpc_id            = aws_vpc.demo_vpc_staging.id
  service_name      = "com.amazonaws.${var.vpc_region_staging}.ssm"
  vpc_endpoint_type = "Interface"
  subnet_ids        = [aws_subnet.pri_1_staging.id, aws_subnet.pri_2_staging.id, aws_subnet.pri_3_staging.id]
  security_group_ids = [aws_security_group.drs_endpoint_sg.id]
  private_dns_enabled = true

  tags = {
    Name = "S3 Interface Endpoint"
  }
}

resource "aws_vpc_endpoint" "s3" {
  provider        = aws.apse2
  vpc_id          = aws_vpc.demo_vpc_staging.id
  service_name    = "com.amazonaws.${var.vpc_region_staging}.s3"
  route_table_ids = [aws_route_table.private_route_table_staging.id]

  tags = {
    Name = "S3 Gateway Endpoint"
  }
}

### EC2 ###
data "aws_ami" "amazon_linux_apse2" {
  provider = aws.apse2
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  owners = ["amazon"]
}

resource "aws_instance" "ec2_stg" {
  provider = aws.apse2
    ami = data.aws_ami.amazon_linux_apse2.id
    monitoring = true
    instance_type = "t2.micro"
    subnet_id = aws_subnet.pri_1_staging.id
    vpc_security_group_ids = [aws_security_group.security_group_ec2.id]
    iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name
    tags = {
        Name = "EC2_1"
    }
}

resource "aws_security_group" "security_group_ec2" {
  provider = aws.apse2
  name        = "Security_Group_EC2"
  vpc_id      = aws_vpc.demo_vpc_staging.id
  description = "Security Group for Private Subnet"

  ingress {
    description = "HTTPS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "TCP from VPC"
    from_port   = 1024
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "HTTPS from VPC"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { 
      Name = "Security Group for Private Subnets" }
}

resource "aws_ec2_instance_connect_endpoint" "example" {
  provider = aws.apse2
  subnet_id = aws_subnet.pri_1_staging.id
}