variable "github_secrets" {
  type = map(string)
}

variable "github_vars" {
  type = map(string)
}

variable "general_tag_shortname" {
  type = string
}
#============================================================
variable "github_repo" {
  description = "Nome do repositório no GitHub"
  type        = string
}

variable "github_branch" {
  description = "Branch do GitHub que será sincronizada"
  type        = string
  default     = "main"
}

variable "github_token" {
  description = "Token de acesso pessoal do GitHub"
  type        = string
}

variable "codebuild_project_name" {
  description = "Nome do projeto CodeBuild"
  type        = string
}

variable "pipeline_name" {
  description = "Nome do pipeline"
  type        = string
}

variable "artifact_bucket" {
  description = "Nome do bucket S3 para armazenar artefatos"
  type        = string
}
