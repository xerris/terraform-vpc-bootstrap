data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_eip" "nat" {
  count = var.count_eip_nat

  vpc = true
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  create_vpc           = var.create_vpc
  name = "${var.vpc_name}-${var.env}"
  cidr = var.vpc_cidr
  azs             = data.aws_availability_zones.available.names
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway = var.enable_natgateway
  single_nat_gateway  = true
  reuse_nat_ips       = true                    # <= Skip creation of EIPs for the NAT Gateways
  external_nat_ip_ids = aws_eip.nat.*.id
  enable_vpn_gateway = var.enable_vpngateway
  enable_dns_hostnames = true

  public_subnet_tags = {
    Name = "project-public-subnet-${var.env}"
  }

  private_subnet_tags = {
    Name = "project-private-subnet-${var.env}"
  }

  tags = {
    Owner       = var.owner_tag
    Environment = var.env
    Terraform   = true
  }
}


output "vpc_data" {
    value ={
        id = local.vpc_id
        priv_subnet_ids = local.subnet_ids
        public_subnet_ids = local.public_subnet_ids
    }
}