output "efs_fs_id" {
  description = "ID File Systeem EFS"
  value       = aws_efs_file_system.glpi_fs.id
}

output "efs_fs_dns" {
  description = "ID File Systeem EFS"
  value       = aws_efs_file_system.glpi_fs.dns_name
}

output "efs_fs_size" {
  description = "ID File Systeem EFS"
  value       = aws_efs_file_system.glpi_fs.size_in_bytes
}

/*
output "efs_fs_ip" {
  description = "Ip File Systeem EFS"
  value       = aws_efs_file_system.glpi_fs.ip
}
*/

/*
output "efs_mount_id" {
  description = "EFS Id Montagem"
  value       = aws_efs_mount_target.mount_fs_glpi.id[*]
}

output "efs_mount_dns_name" {
  description = "EFS Id Montagem"
  value       = aws_efs_mount_target.mount_fs_glpi.dns_name[*]
}

output "efs_mount_dns_mount_name" {
  description = "EFS Id Montagem"
  value       = aws_efs_mount_target.mount_fs_glpi.mount_target_dns_name[*]
}

output "efs_mount_ip_addr" {
  description = "EFS Id Montagem"
  value       = aws_efs_mount_target.mount_fs_glpi.ip_address[*]
}
*/