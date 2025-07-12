terraform {
  backend "s3" {
    bucket = "crfjunior-remote-state"
    key    = "RemoteState/Projeto20/RDS/terraform.tfstate"
    region = "us-east-1"
    #dynamodb_table = "meu-lock-dynamodb"  # Para locking
    #encrypt        = true                 # Criptografar o arquivo de estado
  }
}