resource "aws_instance" "ec2_orquestrador" {
  #count = 1
  #ami   = var.amis["Ubnt-us-east-1"]
  #ami           = data.aws_ami.ubuntu_linux.id
  #data.terraform_remote_state.remote-state-information.outputs.autor
  ami           = data.terraform_remote_state.vpc.outputs.ami_amazon_linux.id
  instance_type = "t2.micro"

  key_name = var.key_name

  #Selecionar VPC
  #vpc_id      = module.vpc.vpc_id

  #Selecionar SubRede
  #subnet_id = module.vpc.vpc_id.public_subnets[0]
  subnet_id = data.terraform_remote_state.vpc.outputs.vpc_public_subnets_id[0]
  # module.vpc.public_subnets[0]

  #Atribuir IP Publico
  associate_public_ip_address = true

  #iam_instance_profile        = data.terraform_remote_state.vpc.outputs.iam_ssm_profile
  #aws_iam_instance_profile.ecs_node.id

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
  iam_instance_profile = data.terraform_remote_state.vpc.outputs.iam_instance_profile_ssm_profile_name
  #aws_iam_instance_profile.ssm_profile.name

  ###
  /*
provisioner "remote-exec" {
    inline = [
      # Mounting Efs 
      #"sudo mount -t nfs -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport ${aws_efs_file_system.efs.dns_name}:/  /var/www/html",
      "sudo mount -t nfs -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport ${data.terraform_remote_state.EFS.efs_fs_dns}:/  /home/ec2-user/GLPI",
      "sleep 15",
      "sudo chmod go+rw /home/ec2-user/GLPI",
      "sudo bash -c 'echo Welcome  > /home/ec2-user/GLPI/index.html'",
    ]
  }
*/
  ###

  tags = {
    Name        = "Orquestrador"
    Terraform   = "true"
    Environment = "Projeto_20"
    Management  = "Terraform"
    Id_EFS      = data.terraform_remote_state.efs.outputs.efs_fs_id
  }
  vpc_security_group_ids = ["${data.terraform_remote_state.vpc.outputs.sg_ssh_id}",
    "${data.terraform_remote_state.vpc.outputs.sg_http_id}",
    "${data.terraform_remote_state.vpc.outputs.sg_rds_id}",
  "${data.terraform_remote_state.vpc.outputs.sg_efs_id}"]
  #vpc_security_group_ids = ["${aws_security_group.acesso-ssh.id}",
  #"${aws_security_group.acesso-http.id}", "${aws_security_group.acesso-rds.id}"]

  provisioner "remote-exec" {
    #depends_on = 
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("~/.ssh/aws-key-terraform")
      host        = self.public_ip
      timeout     = "35s"
    }

    inline = [
      # Instalar o cliente NFS
      "sudo yum update -y",
      "sudo yum upgrade -y",

      # Criar diretório para montagem
      "sudo mkdir -p /mnt/efs",
      "sleep 120",

      # Montar o EFS
      "sudo mount -t efs ${data.terraform_remote_state.efs.outputs.efs_fs_id}:/ /home/ec2-user/GLPI",
      "sudo chmod go+rw /home/ec2-user/GLPI",
      "sudo bash -c 'echo Welcome  > /home/ec2-user/GLPI/index.html'",
      "sudo chown -R ec2-user:ec2-user /home/ec2-user/",

      # Persistir a montagem (opcional)
      "sudo bash -c echo '${data.terraform_remote_state.efs.outputs.efs_fs_id}:/ /home/ec2-user/GLPI efs defaults,_netdev 0 0' | sudo tee -a /etc/fstab"
    ]
  }

}
