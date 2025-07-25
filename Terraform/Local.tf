locals {
  region = "eu-west-1"
  name   = "ex-${basename(path.cwd)}"

  vpc_cidr = "10.20.0.0/16"
  #azs      = slice(data.aws_availability_zones.available.names, 0, 3)

  container_name = "ecsprojeto20-frontend"
  container_port = 80

  tags = {
    Name       = local.name
    Example    = local.name
    Repository = "https://github.com/terraform-aws-modules/terraform-aws-ecs"
  }
}
