output "ssm_role" {
  value = aws_iam_role.ssm_role.id
}

output "ssm_atach_role" {
  value = aws_iam_role_policy_attachment.ssm_managed_policy
}

output "sg_acesso_alb" {
  value = aws_iam_role_policy_attachment.ssm_managed_policy.id
}

####

output "ami_ubuntu_linux" {
  description = "value"
  value       = data.aws_ami.ubuntu_linux
}

output "ami_amazon_linux" {
  description = "value"
  value       = data.aws_ami.amazon_linux
}
/*
 name    = "Projeto_20-vpc"
  cidr    = "10.20.0.0/16"

  azs              = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets  = ["10.20.201.0/24", "10.20.202.0/24", "10.20.203.0/24"]
  public_subnets   = ["10.20.101.0/24", "10.20.102.0/24", "10.20.103.0/24"]
  database_subnets = ["10.20.21.0/24", "10.20.22.0/24", "10.20.23.0/24"]

*/

output "vpc_name" {
  description = "Id da VPC"
  value       = module.vpc.name
}

output "vpc_azs_id" {
  description = "Relacai Ids das AZs"
  value       = module.vpc.azs[*] #private_subnets[*]
}

#module.vpc.public_subnets[0]
output "vpc_public_subnets_id" {
  description = "SubNets Publica"
  value       = module.vpc.public_subnets[*]
}

#module.vpc.public_subnets[0]
output "vpc_private_subnets_id" {
  description = "Relacai Ids das SubNets Privadas"
  value       = module.vpc.private_subnets[*]
}

#database_subnet_arns
output "vpc_database_subnet_arns" {
  value = module.vpc.database_subnet_arns
}

#private_subnets_cidr_blocks
output "vpc_private_subnets_cidr_blocks" {
  value = module.vpc.private_subnets_cidr_blocks
}
#public_subnets_cidr_blocks
output "vpc_public_subnets_cidr_blocks" {
  value = module.vpc.public_subnets_cidr_blocks
}
#vpc_cidr_block
output "vpc_vpc_cidr_block" {
  value = module.vpc.vpc_cidr_block
}
#vpc_id
output "vpc_vpc_id" {
  value = module.vpc.vpc_id
}


######################

#aws_iam_instance_profile.ssm_profile.name
output "iam_instance_profile_ssm_profile_name" {
  description = "SubNets Publicavalue"
  value       = aws_iam_instance_profile.ssm_profile.name
}

output "sg_ecs_service_rule_id" {
  value = aws_security_group.ecs_service_rule.id
}

#aws_security_group.acesso-ssh.id
output "sg_ssh_id" {
  description = "SG Acesso a Instancia Id"
  value       = aws_security_group.acesso-ssh.id
}

#aws_security_group.acesso-http.id
output "sg_http_id" {
  description = "SG Acesso a Instancia Id"
  value       = aws_security_group.acesso-http.id
}

#aws_security_group.acesso-rds.id
output "sg_rds_id" {
  description = "SG Acesso a Instancia Id"
  value       = aws_security_group.acesso-rds.id
}

output "sg_efs_id" {
  description = "SG EFS id"
  value       = aws_security_group.efs_sg.id
}

output "sg_efs" {
  description = "SG EFS "
  value       = aws_security_group.efs_sg
}

#aws_iam_instance_profile.ssm_profile
output "iam_ssm_profile" {
  description = "Role SSM Profile"
  value       = aws_iam_instance_profile.ssm_profile
}

#aws_db_instance.db-Projeto20.endpoint
#output "endpoint_db" {
#  description = "EndPoint DB Instance"
#  value = aws_db_instance.db-Projeto20.endpoint
#} 

#aws_lb.main.dns_name
#output "load_balancer_dns" {
#  description = "LB DNS"
#  value = aws_lb.main.dns_name
#} 

#aws_s3_bucket.s3-remote-state.bucket
#output "remote_state_bucket_name" {
#  description = "rsb Name"
#  value = aws_s3_bucket.s3-remote-state.bucket
#} 

#aws_s3_bucket.s3-remote-state.arn
#output "remote_state_bucket_arn" {
#  description = "rsb ARN"
#  value = aws_s3_bucket.s3-remote-state.arn
#} 
