variable "amis" {
  type = map(any)
  default = {
    "Ubnt-us-east-1" = "ami-0261755bbcb8c4a84"
    "Ubnt-us-east-2" = "ami-0430580de6244e02e"
  }

}

variable "cdirs_acesso_remoto" {
  type    = list(any)
  default = ["0.0.0.0/0", "187.180.212.28/32", "200.181.118.98/32"]
}

variable "key_name" {
  type    = string
  default = "KeyPar-072024"

}

variable "dynamic_scaling" {
  description = "Enable/disable dynamic scaling of the auto scaling group."
  type        = bool
  default     = false
}

variable "dynamic_scaling_adjustment" {
  description = "The adjustment in number of instances for dynamic scaling."
  type        = number
  default     = 1
}

variable "environment" {
  description = "Name of the environment; will be prefixed to all resources."
  type        = string
  default     = "Projeto20"
}

variable "app_count" {
  type    = number
  default = 2
}

variable "user_names" {
  description = "Name of the User."
  type        = list(string)
  default     = ["XXX", "YYY", "ZZZ"]
}

###

#variable "projeto" {
#  type        = string
#  description = "Descrição do projeto."
#}

#variable "cliente" {
#  type        = string
#  description = "Cliente do projeto."
#}

#variable "autor" {
#  type        = string
#  description = "Autor de edição."
#}

#variable "shortnameid" {
#  type        = string
#  description = "Nome curto para identificação dos recursos na AWS"
#}

#variable "regiao" {
#  type        = string
#  description = "Região onde a infraestrutura será criada."
#}

#variable "remote-state-bucket" {
#  type        = string
#  description = "Bucket name onde está o remote state"
#}