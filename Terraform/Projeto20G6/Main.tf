data "aws_availability_zones" "available_zones" {
  state = "available"
}

locals {
  region = "eu-west-1"
  name   = "ex-${basename(path.cwd)}"

  vpc_cidr = "10.20.0.0/16"
  #azs      = slice(data.aws_availability_zones.available.names, 0, 3)

  container_name = "ecsprojeto14-frontend"
  container_port = 80

  tags = {
    Name       = local.name
    Example    = local.name
    Repository = "https://github.com/terraform-aws-modules/terraform-aws-ecs"
  }
}

data "aws_caller_identity" "current" {}


data "aws_ami_ids" "ubuntu-ami" {

  filter {
    name   = "name"
    values = ["ubuntu/images/ubuntu-*-*-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical
}

data "aws_ami_ids" "amzn-linux-2023-ami" {
  #most_recent = true
  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}


#environment = "Projeto20"

#data "aws_iam_policy_document" "teste" {
#  #most_recent = true
#  owners = ["amazon"]#

#  filter {
#    name   = "name"
#    values = ["al2023-ami-2023.*-x86_64"]
#  }
#}
