output "ecr_repository_arn" {
  description = "App ECR repository Information"
  value       = aws_ecr_repository.glpi_repository.arn
  #aws_ecr_repository.glpi_repository.repository.ecr_repository_arn
}

output "ecr_repository_id" {
  description = "App ECR repository Information"
  value       = aws_ecr_repository.glpi_repository.id
}

output "ecr_repository_name" {
  description = "App ECR repository Information"
  value       = aws_ecr_repository.glpi_repository.name
}

output "ecr_repository_tags_all" {
  description = "App ECR repository Information"
  value       = aws_ecr_repository.glpi_repository.tags_all
}

output "ecr_repository_registry_id" {
  description = "App ECR repository Information"
  value       = aws_ecr_repository.glpi_repository.registry_id
}

output "ecr_repository_url" {
  description = "App ECR repository Information"
  value       = aws_ecr_repository.glpi_repository.repository_url
}
/*
output "ecr_repository_uri" {
  description = "App ECR repository Information"
  value       = aws_ecr_repository.glpi_repository.repository_uri
}
*/
#Testes connection GitHub
output "data_codestarconnections_arn" {
  value = data.aws_codestarconnections_connection.github_app_connection.arn
}
output "data_codestarconnections_status_connection" {
  value = data.aws_codestarconnections_connection.github_app_connection.connection_status
}
output "data_codestarconnections_host_arn" {
  value = data.aws_codestarconnections_connection.github_app_connection.host_arn
}
output "data_codestarconnections_id" {
  value = data.aws_codestarconnections_connection.github_app_connection.id
}
output "data_codestarconnections_name" {
  value = data.aws_codestarconnections_connection.github_app_connection.name
}
output "data_codestarconnections_provider" {
  value = data.aws_codestarconnections_connection.github_app_connection.provider_type
}
output "data_codestarconnections_tags" {
  value = data.aws_codestarconnections_connection.github_app_connection.tags
}