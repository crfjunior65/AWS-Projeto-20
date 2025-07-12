resource "aws_instance" "ec2_orquestrador" {
  count = 1
  #ami   = var.amis["Ubnt-us-east-1"]
  ami          = data.aws_ami.ubuntu_linux.id
  instance_type = "t2.micro"

  key_name = var.key_name

  #Selecionar VPC
  #vpc_id      = module.vpc.vpc_id

  #Selecionar SubRede
  #subnet_id = module.vpc.vpc_id.public_subnets[0]
  subnet_id = module.vpc.public_subnets[0]

  #Atribuir IP Publico
  associate_public_ip_address = true
  #iam_instance_profile        = aws_iam_instance_profile.ecs_node.id
  #Definir Volume

  user_data = file("InstallTerrafor.sh")

  #user_data = << EOF
  #              #! /bin/bash
  #              cd /home/ubuntu
  #              apt update -y
  #              apt upgrade -y
  #              apt install wget unzip -y
  #              TER_VER=$(curl -s https://api.github.com/repos/hashicorp/terraform/releases/latest | grep tag_name | cut -d: -f2 | tr -d \"\,\v | awk '{$1=$1};1')
  #              wget https://releases.hashicorp.com/terraform/${TER_VER}/terraform_${TER_VER}_linux_amd64.zip
  #              unzip terraform_${TER_VER}_linux_amd64.zip
  #              mv terraform /usr/local/bin/
  #              EOF

  # Associar o Role SSM à instância EC2
  iam_instance_profile = aws_iam_instance_profile.ssm_profile.name

  tags = {
    Name        = "Orquestrador-${count.index}"
    Terraform   = "true"
    Environment = "Projeto_20"
    Management  = "Terraform"
  }
  vpc_security_group_ids = ["${aws_security_group.acesso-ssh.id}",
  "${aws_security_group.acesso-http.id}", "${aws_security_group.acesso-rds.id}"]
}

/*
resource "aws_security_group" "acesso-ssh" {
  vpc_id = module.vpc.public_subnets.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Permite acesso SSH de qualquer lugar
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
*/
#vpc_security_group_ids = [aws_security_group.acesso-rds.id]
#resource "aws_instance" "app_server4" {
#  #count = 3
#  ami           = var.amis["Ubnt-us-east-1"]
#  instance_type = "t2.micro"
#  key_name = var.key_name

#  tags = {
#    Name = "Terraform-Dev-4"       ###${count.index}"
#  }
#  vpc_security_group_ids = ["${aws_security_group.acesso-ssh.id}"]
#  depends_on = [ aws_s3_bucket.Dev4 ]
#}

#resource "aws_instance" "app_server7" {
#  #provider = aws.us-east-2
#  #count = 3
#  ami           = var.amis["Ubnt-us-east-2"]
#  instance_type = "t2.micro"
#  key_name = var.key_name

#  tags = {
#    Name = "Terraform-Dev-7"       ###${count.index}"
#  }
#  vpc_security_group_ids = ["${aws_security_group.acesso-ssh.id}"]
#  #depends_on = [ aws_dynamodb_table.basic-dynamodb-table ]
#}
