resource "aws_db_instance" "db-Projeto20" {
  allocated_storage    = 10
  db_name              = "glpi"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  deletion_protection  = false
  identifier           = "db-projeto20"
  multi_az             = false
  username             = "root"
  password             = "glpiglpi"
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true

  #depends_on = [module.vpc]
  #Selecionar VPC
  
  #vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  #Selecionar SubRede
  #subnet_id = module.vpc.private_subnets
  db_subnet_group_name = data.terraform_remote_state.vpc.outputs.vpc_name
  #db_subnet_group_name   = module.vpc.database_subnets

  vpc_security_group_ids = [data.terraform_remote_state.vpc.outputs.sg_rds_id]
  #    aws_security_group.acesso-rds.id]


  tags = {
    "Environment" = "Projeto_20"
    "Management"  = "Terraform"
    "Name"        = "db-projeto20"
    "Terraform"   = "true"
  }
}