### Main VPC
variable "vpc_cidr" {}
variable "vpc_region" {}

variable "pub_1_subnet_cidr_block" {}
variable "pub_1_subnet_az" {}

variable "pub_2_subnet_cidr_block" {}
variable "pub_2_subnet_az" {}

variable "pub_3_subnet_cidr_block" {}
variable "pub_3_subnet_az" {}

variable "pri_1_subnet_cidr_block" {}
variable "pri_1_subnet_az" {}

variable "pri_2_subnet_cidr_block" {}
variable "pri_2_subnet_az" {}

variable "pri_3_subnet_cidr_block" {}
variable "pri_3_subnet_az" {}

### Staging VPC
variable "vpc_cidr_staging" {}
variable "vpc_region_staging" {}

# variable "pub_1_sec_subnet_cidr_block" {}
# variable "pub_1_subnet_az_sec" {}

# variable "pub_2_sec_subnet_cidr_block" {}
# variable "pub_2_subnet_az_sec" {}

# variable "pub_3_sec_subnet_cidr_block" {}
# variable "pub_3_subnet_az_sec" {}

variable "pri_1_staging_subnet_cidr_block" {}
variable "pri_1_subnet_az_staging" {}

variable "pri_2_staging_subnet_cidr_block" {}
variable "pri_2_subnet_az_staging" {}

variable "pri_3_staging_subnet_cidr_block" {}
variable "pri_3_subnet_az_staging" {}

### Secondary VPC
variable "vpc_cidr_sec" {}
variable "vpc_region_sec" {}

variable "pub_1_sec_subnet_cidr_block" {}
variable "pub_1_subnet_az_sec" {}

variable "pub_2_sec_subnet_cidr_block" {}
variable "pub_2_subnet_az_sec" {}

variable "pub_3_sec_subnet_cidr_block" {}
variable "pub_3_subnet_az_sec" {}

variable "pri_1_sec_subnet_cidr_block" {}
variable "pri_1_subnet_az_sec" {}

variable "pri_2_sec_subnet_cidr_block" {}
variable "pri_2_subnet_az_sec" {}

variable "pri_3_sec_subnet_cidr_block" {}
variable "pri_3_subnet_az_sec" {}