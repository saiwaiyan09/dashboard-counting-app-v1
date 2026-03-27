module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.6.0"

  name                    = var.vpc_name
  cidr                    = var.vpc_cidr
  azs                     = [var.azs[0]]
  private_subnets         = [var.subnet_private]
  public_subnets          = [var.subnet_public]
  enable_dns_hostnames    = var.enable_dns_hostnames
  enable_nat_gateway      = var.enable_nat_gateway
  single_nat_gateway      = var.single_nat_gateway
  map_public_ip_on_launch = var.map_public_ip_on_launch

  tags = {
    name        = "${var.prefix}-vpc-${var.region}"
    environment = "${var.environment}"
  }
}