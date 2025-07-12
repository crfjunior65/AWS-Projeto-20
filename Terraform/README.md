# Terraform - Infrastructure as Code

## Contexto do Diretório

Este diretório contém toda a infraestrutura como código (IaC) do projeto AWS-Projeto-20, responsável por provisionar e gerenciar os recursos AWS necessários para hospedar o sistema GLPI na nuvem. A infraestrutura é modularizada e organizada por componentes específicos, seguindo as melhores práticas de Terraform.

### Finalidade Principal
- Provisionar infraestrutura AWS de forma automatizada e versionada
- Gerenciar recursos de rede, computação, armazenamento e banco de dados
- Implementar arquitetura escalável e resiliente para o GLPI
- Facilitar deploy e manutenção através de código

### Relação com Outros Componentes
- **Docker**: Utiliza imagens containerizadas criadas no diretório Docker
- **Diagrama**: Implementa a arquitetura definida nos diagramas
- **Entrega**: Suporta os requisitos documentados nas propostas

### Tecnologias/Linguagens Principais
- **Terraform** (HCL) - Infrastructure as Code
- **AWS Provider** - Integração com serviços AWS
- **Bash Scripts** - Automação e instalação

## Estrutura de Arquivos

```
Terraform/
├── 0-GitHub-Sync/          # Sincronização com GitHub
├── 1-EFS/                  # Elastic File System
├── 2-RDS/                  # Relational Database Service
├── 3-Bucket/               # S3 Buckets
├── 4-ECR/                  # Elastic Container Registry
├── 5-ECS/                  # Elastic Container Service
├── 6-Builder/              # CodeBuild para CI/CD
├── config/                 # Configurações por ambiente
│   ├── dev/               # Ambiente de desenvolvimento
│   ├── local/             # Ambiente local
│   └── prod/              # Ambiente de produção
├── Orquestrador/          # EC2 para orquestração
├── Projeto20G6/           # Configurações específicas do grupo
├── Projeto20G6-CICD/     # Pipeline CI/CD
├── RemoteState/           # Gerenciamento de estado remoto
├── Testes/                # Ambientes de teste
├── Main.tf                # Configuração principal
├── Provider.tf            # Configuração do provider AWS
├── Variables.tf           # Definição de variáveis
├── Outputs.tf             # Outputs dos recursos
├── Backend.tf             # Configuração do backend
├── Data.tf                # Data sources
├── VpcModule.tf           # Módulo VPC
└── SecurityGroup.tf       # Grupos de segurança
```

## Fluxo de Trabalho

### 1. Inicialização
```bash
terraform init
```

### 2. Planejamento
```bash
terraform plan -var-file="config/prod/terraform.tfvars"
```

### 3. Aplicação
```bash
terraform apply -var-file="config/prod/terraform.tfvars"
```

### 4. Destruição (quando necessário)
```bash
terraform destroy -var-file="config/prod/terraform.tfvars"
```

### Dependências Importantes
- **AWS CLI** configurado com credenciais apropriadas
- **Terraform** versão >= 1.0
- **Backend S3** para armazenamento do estado
- **DynamoDB** para lock do estado

## Configuração

### Variáveis de Ambiente Principais
```hcl
# terraform.tfvars
region = "us-east-1"
environment = "prod"
project_name = "Projeto20"
vpc_cidr = "10.20.0.0/16"
```

### Pré-requisitos de Instalação
1. **AWS CLI** instalado e configurado
2. **Terraform** instalado (versão >= 1.0)
3. **Credenciais AWS** com permissões adequadas
4. **S3 Bucket** para backend (criado no RemoteState)

### Configuração do Backend
```hcl
terraform {
  backend "s3" {
    bucket         = "projeto20-terraform-state"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "projeto20-terraform-locks"
    encrypt        = true
  }
}
```

## Boas Práticas

### 1. Organização Modular
- Cada serviço AWS em diretório separado
- Reutilização de módulos quando possível
- Separação clara entre recursos e configurações

### 2. Gerenciamento de Estado
- Estado remoto no S3 com criptografia
- Lock distribuído com DynamoDB
- Backup automático do estado

### 3. Segurança
- Uso de roles IAM específicas
- Criptografia em trânsito e repouso
- Grupos de segurança restritivos

### 4. Versionamento
- Tags consistentes em todos os recursos
- Versionamento de módulos
- Documentação de mudanças

### 5. Ambientes
- Configurações separadas por ambiente
- Uso de workspaces quando apropriado
- Validação antes de aplicar em produção

## Comandos Úteis

### Validação
```bash
terraform validate
terraform fmt -recursive
```

### Importação de Recursos Existentes
```bash
terraform import aws_instance.example i-1234567890abcdef0
```

### Visualização de Dependências
```bash
terraform graph | dot -Tpng > graph.png
```

### Troubleshooting
```bash
terraform refresh
terraform state list
terraform state show <resource>
```

## Recursos Principais Provisionados

- **VPC** com subnets públicas e privadas
- **EC2** para orquestração e aplicação
- **RDS** para banco de dados MySQL
- **EFS** para armazenamento compartilhado
- **S3** para artefatos e backups
- **ECR** para imagens Docker
- **ECS** para containers
- **ALB** para balanceamento de carga
- **CloudFront** para CDN
- **CodeBuild** para CI/CD

## Monitoramento e Logs

- **CloudWatch** para métricas e logs
- **CloudTrail** para auditoria
- **Config** para compliance
- **Systems Manager** para gerenciamento

## Contatos e Suporte

Para dúvidas ou suporte relacionado à infraestrutura:
- Equipe: Grupo 6 - Projeto 20
- Documentação: Consulte o diretório `Entrega/`
- Diagramas: Consulte o diretório `Diagrama/`
