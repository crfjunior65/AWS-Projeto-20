resource "aws_efs_file_system" "glpi_fs" {
  creation_token = "fs_glpi"

  tags = {
    Name = "EFS GLPI"
  }
}

resource "aws_efs_mount_target" "mount_fs_glpi" {
  count           = 3
  file_system_id  = aws_efs_file_system.glpi_fs.id
  subnet_id       = data.terraform_remote_state.vpc.outputs.vpc_private_subnets_id[count.index]
  security_groups = [data.terraform_remote_state.vpc.outputs.sg_efs_id]
}

/*
resource "aws_efs_mount_target" "efs-mt" {
  #count           = length(data.aws_availability_zones.available.names)
  file_system_id  = aws_efs_file_system.glpi_fs.id
  subnet_id       = data.terraform_remote_state.vpc.outputs.vpc_private_subnets_id[0] #####aws_subnet.subnet[count.index].id
  security_groups = [data.terraform_remote_state.vpc.outputs.sg_efs_id]
}
*/
/*
# Creating Mount Point for EFS
resource "null_resource" "configure_nfs" {
  depends_on = [aws_efs_mount_target.mount_fs_glpi]
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("~/.ssh/aws-key-terraform")
    host        = data.terraform_remote_state.orquestrador.outputs.public_ip
    timeout     = "35s"
  }

  provisioner "remote-exec" {
    inline = [
      # Mounting Efs 
      "sudo mount -t nfs -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport ${aws_efs_file_system.glpi_fs.dns_name}:/  /home/ec2-user/GLPI/",
      "sleep 25",
      "sudo bash -c 'echo ´${aws_efs_file_system.glpi_fs.id}:/    /home/ec2-user/GLPI  nfs auto,nofail,noatime,nolock,intr,tcp,actimeo=1800 0 0´ >>/home/ec2-user/fstab'",
      "sudo chmod go+rw /home/ec2-user/GLPI",
      "sudo bash -c 'echo Welcome  > /home/ec2-user/GLPI/index.html'",
      "sudo chown -R ec2-user:ec2-user /home/ec2-user/"
    ]
  }
}
*/



# subnet id subnet-0e46f4f0c6b113d93 #####
/*
resource "aws_vpc" "foo" {
  cidr_block = data.terraform_remote_state.vpc.outputs.vpc_vpc_cidr_block
}

resource "aws_subnet" "privada" {
  count             = 3
  vpc_id            = data.terraform_remote_state.vpc.outputs.vpc_name
  availability_zone = data.terraform_remote_state.vpc.outputs.vpc_azs_id[count.index]
  cidr_block        = data.terraform_remote_state.vpc.outputs.vpc_private_subnets_cidr_blocks[count.index]
}
https://www.youtube.com/watch?v=KvlHLJkJ0bY
https://github.com/CumulusCycles/IaC_on_AWS_with_Terraform/blob/main/src/5_Terraform_ECR_ECS/main.tf
https://github.com/Juanmichael00/terraform/blob/main/modulo-efs/efs.tf
https://www.youtube.com/watch?v=bIPF_hzmQGE&list=PLWQmZVQayUUIgSmOj3GPH2BJcn0hOzIaP
https://www.youtube.com/watch?v=bIPF_hzmQGE&list=PLWQmZVQayUUIgSmOj3GPH2BJcn0hOzIaP
https://www.youtube.com/watch?v=bIPF_hzmQGE&list=PLWQmZVQayUUIgSmOj3GPH2BJcn0hOzIaP
https://github.com/itirohidaka




*/
