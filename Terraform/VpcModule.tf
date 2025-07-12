module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  #source  = "terraform-aws-modules/vpc/aws" 5.1.2
  version = "5.1.2"
  name    = "Projeto_20-vpc"
  cidr    = "10.20.0.0/16"

  azs              = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets  = ["10.20.201.0/24", "10.20.202.0/24", "10.20.203.0/24"]
  public_subnets   = ["10.20.101.0/24", "10.20.102.0/24", "10.20.103.0/24"]
  database_subnets = ["10.20.21.0/24", "10.20.22.0/24", "10.20.23.0/24"]
  #assign_generated_ipv6_cidr_block = true

  #lifecycle {
  #  prevent_destroy = true
  #}

  enable_dns_hostnames   = true
  enable_nat_gateway     = false
  single_nat_gateway     = false
  enable_vpn_gateway     = false
  one_nat_gateway_per_az = false
  ##reuse_nat_ips = true
  #external_nat_ip_ids = "${aws_eip.nat.*.id}"
  ##manage_default_network_acl = true

  public_subnet_tags = {
    Name = "Projeto_20-SubNet-public"
  }

  private_subnet_tags = {
    Name = "Projeto_20-SubNet-privada"
  }

  tags = {
    Terraform   = "true"
    Environment = "Projeto_20"
    Management  = "Terraform"
  }
}



