### VPC ###
resource "aws_vpc" "demo_vpc_sec" {
  provider             = aws.apse2
  cidr_block           = var.vpc_cidr_sec
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "CAMPF_VPC_Secondary"
  }
}

# ### IGW ###
resource "aws_internet_gateway" "igw_sec" {
  provider = aws.apse2
  vpc_id   = aws_vpc.demo_vpc_sec.id
  tags = {
    Name = "Internet Gateway"
  }
}

# ### NAT Gateway ###
resource "aws_eip" "nat_gateway_ip_sec" {
  provider = aws.apse2
  domain   = "vpc"
}

resource "aws_nat_gateway" "nat_gateway_sec" {
  provider      = aws.apse2
  allocation_id = aws_eip.nat_gateway_ip_sec.id
  subnet_id     = aws_subnet.pub_1_sec.id
  depends_on    = [aws_internet_gateway.igw_sec]
  tags = {
    Name = "NAT Gateway Sec"
  }
}

### VPC Subnets ###
resource "aws_subnet" "pub_1_sec" {
  provider          = aws.apse2
  vpc_id            = aws_vpc.demo_vpc_sec.id
  cidr_block        = var.pub_1_sec_subnet_cidr_block
  availability_zone = var.pub_1_subnet_az_sec

  tags = {
    Name = "Pub_1"
  }
}

resource "aws_subnet" "pub_2_sec" {
  provider          = aws.apse2
  vpc_id            = aws_vpc.demo_vpc_sec.id
  cidr_block        = var.pub_2_sec_subnet_cidr_block
  availability_zone = var.pub_2_subnet_az_sec

  tags = {
    Name = "Pub_2"
  }
}

resource "aws_subnet" "pub_3_sec" {
  provider          = aws.apse2
  vpc_id            = aws_vpc.demo_vpc_sec.id
  cidr_block        = var.pub_3_sec_subnet_cidr_block
  availability_zone = var.pub_3_subnet_az_sec

  tags = {
    Name = "Pub_3"
  }
}

resource "aws_subnet" "pri_1_sec" {
  provider          = aws.apse2
  vpc_id            = aws_vpc.demo_vpc_sec.id
  cidr_block        = var.pri_1_sec_subnet_cidr_block
  availability_zone = var.pri_1_subnet_az_sec

  tags = {
    Name = "Pri_1"
  }
}

resource "aws_subnet" "pri_2_sec" {
  provider          = aws.apse2
  vpc_id            = aws_vpc.demo_vpc_sec.id
  cidr_block        = var.pri_2_sec_subnet_cidr_block
  availability_zone = var.pri_2_subnet_az_sec

  tags = {
    Name = "Pri_2"
  }
}

resource "aws_subnet" "pri_3_sec" {
  provider          = aws.apse2
  vpc_id            = aws_vpc.demo_vpc_sec.id
  cidr_block        = var.pri_3_sec_subnet_cidr_block
  availability_zone = var.pri_3_subnet_az_sec

  tags = {
    Name = "Pri_3"
  }
}

### Route Tables ###
resource "aws_route_table" "public_route_table_sec" {
  provider = aws.apse2
  vpc_id   = aws_vpc.demo_vpc_sec.id
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
  vpc_id   = aws_vpc.demo_vpc_sec.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gateway_sec.id
  }
  tags = {
    Name = "Private Route Table"
  }
}

resource "aws_route_table_association" "pub_1_sec" {
  provider       = aws.apse2
  subnet_id      = aws_subnet.pub_1_sec.id
  route_table_id = aws_route_table.public_route_table_sec.id
}

resource "aws_route_table_association" "pub_2_sec" {
  provider       = aws.apse2
  subnet_id      = aws_subnet.pub_2_sec.id
  route_table_id = aws_route_table.public_route_table_sec.id
}

resource "aws_route_table_association" "pub_3_sec" {
  provider       = aws.apse2
  subnet_id      = aws_subnet.pub_3_sec.id
  route_table_id = aws_route_table.public_route_table_sec.id
}

resource "aws_route_table_association" "pri_1_sec" {
  provider       = aws.apse2
  subnet_id      = aws_subnet.pri_1_sec.id
  route_table_id = aws_route_table.private_route_table_sec.id
}

resource "aws_route_table_association" "pri_2_sec" {
  provider       = aws.apse2
  subnet_id      = aws_subnet.pri_2_sec.id
  route_table_id = aws_route_table.private_route_table_sec.id
}

resource "aws_route_table_association" "pri_3_sec" {
  provider       = aws.apse2
  subnet_id      = aws_subnet.pri_3_sec.id
  route_table_id = aws_route_table.private_route_table_sec.id
}

### NACL for Public Subnets ###
resource "aws_network_acl" "nacl_public_sec" {
  provider   = aws.apse2
  vpc_id     = aws_vpc.demo_vpc_sec.id
  subnet_ids = [aws_subnet.pub_1_sec.id, aws_subnet.pub_2_sec.id, aws_subnet.pub_3_sec.id]

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
    Name = "Public NACL"
  }
}

### NACL for Private Subnets ###
resource "aws_network_acl" "nacl_private_sec" {
  provider   = aws.apse2
  vpc_id     = aws_vpc.demo_vpc_sec.id
  subnet_ids = [aws_subnet.pri_1_sec.id, aws_subnet.pri_2_sec.id, aws_subnet.pri_3_sec.id]

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

resource "aws_route" "sec_to_staging" {
  provider                  = aws.apse2
  route_table_id            = aws_route_table.private_route_table_sec.id
  destination_cidr_block    = var.vpc_cidr_staging
  vpc_peering_connection_id = aws_vpc_peering_connection.staging_to_sec.id
}


### Security Group ###
resource "aws_security_group" "security_group_2" {
    provider = aws.apse2
  name        = "Security_Group_2"
  vpc_id      = aws_vpc.demo_vpc_sec.id
  description = "Security Group for Private Subnet"

  ingress {
    description = "HTTPS from VPC"
    from_port   = 443
    to_port     = 443
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

### ALB ###
resource "aws_lb_target_group" "ec2_instances_sec" {
    provider = aws.apse2
  name        = "tf-campf-demo-sec"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = aws_vpc.demo_vpc_sec.id
}

# resource "aws_lb_target_group_attachment" "my-alb-target-group-attachment1" {
#   target_group_arn = aws_lb_target_group.ec2_instances.arn
#   target_id        = aws_instance.ec2_1.id
#   port             = 80
# }

# resource "aws_lb_target_group_attachment" "my-alb-target-group-attachment2" {
#   target_group_arn = aws_lb_target_group.ec2_instances.arn
#   target_id        = aws_instance.ec2_2.id
#   port             = 80
# }

resource "aws_lb" "tf_campf_demo_alb_sec" {
    provider = aws.apse2
  name                       = "tf-campf-demo-alb-sec"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.security_group_2.id]
  subnets                    = [aws_subnet.pub_1_sec.id, aws_subnet.pub_2_sec.id]
  ip_address_type            = "ipv4"
  drop_invalid_header_fields = true
  enable_deletion_protection = false #False if for testing

  tags = {
    Name = "TF_CAMPF_Demo_ALB_Sec"
  }
}

resource "aws_lb_listener" "front_end_sec" {
    provider = aws.apse2
  load_balancer_arn = aws_lb.tf_campf_demo_alb_sec.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ec2_instances_sec.arn
  }
}