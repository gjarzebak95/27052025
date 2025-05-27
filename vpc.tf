module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  name = "image-upload-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["eu-central-1a", "eu-central-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]

  enable_nat_gateway = false
  enable_vpn_gateway = false

  # DNS Settings
  enable_dns_hostnames = true
  enable_dns_support   = true

  # Route table settings
  manage_default_route_table = true
  default_route_table_tags   = { Name = "default-rt" }
  private_route_table_tags   = { Name = "private-rt" }

  tags = {
    Terraform = "true"
  }
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id       = module.vpc.vpc_id
  service_name = "com.amazonaws.eu-central-1.s3"

  route_table_ids = module.vpc.private_route_table_ids

  tags = {
    Name = "s3-vpc-endpoint"
  }
} 