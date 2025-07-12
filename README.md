# AWS-Projeto-20 - Migração GLPI para AWS Cloud

![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?style=for-the-badge&logo=amazon-aws&logoColor=white)
![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)
![GitHub Actions](https://img.shields.io/badge/github%20actions-%232671E5.svg?style=for-the-badge&logo=githubactions&logoColor=white)
![Magento](https://img.shields.io/badge/Magento-FF6C37?style=for-the-badge&logo=magento&logoColor=white)
![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)

## Visão Geral do Projeto

O **AWS-Projeto-20** é um projeto de migração do sistema GLPI (Gestão Livre de Parque de Informática) para a nuvem AWS, desenvolvido pelo Grupo 6 da Oficina de Projetos 20 da Cloud Treinamentos. O projeto implementa uma arquitetura moderna, escalável e resiliente utilizando as melhores práticas de cloud computing.

### Objetivo Principal
Migrar o sistema GLPI da empresa fictícia Upper Plan de uma infraestrutura on-premises para a nuvem AWS, proporcionando maior disponibilidade, escalabilidade e redução de custos operacionais.

### Contexto Empresarial
A Upper Plan enfrentava desafios com lentidão e limitações de escalabilidade do seu sistema de gestão de chamados GLPI. A migração para AWS visa resolver esses problemas e modernizar a infraestrutura de TI.

## Arquitetura da Solução

### Diagrama de Alto Nível
```
┌─────────────────────────────────────────────────────────────────┐
│                        AWS Cloud                                │
│                                                                 │
│  ┌─────────────────┐    ┌─────────────────┐    ┌─────────────┐ │
│  │   CloudFront    │    │      Route 53   │    │     WAF     │ │
│  │   (CDN/Cache)   │    │      (DNS)      │    │ (Security)  │ │
│  └─────────┬───────┘    └─────────────────┘    └─────────────┘ │
│            │                                                   │
│  ┌─────────▼───────┐    ┌─────────────────┐    ┌─────────────┐ │
│  │      ALB        │    │       ECS       │    │     ECR     │ │
│  │ (Load Balancer) │────│   (Containers)  │────│ (Registry)  │ │
│  └─────────────────┘    └─────────┬───────┘    └─────────────┘ │
│                                   │                           │
│  ┌─────────────────┐    ┌─────────▼───────┐    ┌─────────────┐ │
│  │      RDS        │    │      EFS        │    │     S3      │ │
│  │   (Database)    │    │  (File System)  │    │ (Storage)   │ │
│  └─────────────────┘    └─────────────────┘    └─────────────┘ │
│                                                                 │
│  ┌─────────────────┐    ┌─────────────────┐    ┌─────────────┐ │
│  │   CloudWatch    │    │   CodeBuild     │    │ Systems Mgr │ │
│  │  (Monitoring)   │    │    (CI/CD)     │    │ (Management)│ │
│  └─────────────────┘    └─────────────────┘    └─────────────┘ │
└─────────────────────────────────────────────────────────────────┘
```

### Componentes Principais
- **VPC**: Rede virtual privada com subnets públicas e privadas
- **ECS**: Orquestração de containers com Fargate
- **RDS**: Banco de dados MySQL gerenciado
- **EFS**: Sistema de arquivos compartilhado
- **ALB**: Application Load Balancer para distribuição de carga
- **CloudFront**: CDN para otimização de performance
- **S3**: Armazenamento de objetos para backups e logs
- **ECR**: Registry para imagens Docker

## Estrutura do Projeto

```
AWS-Projeto-20/
├── 📁 Terraform/              # Infrastructure as Code
│   ├── 📁 1-EFS/             # Elastic File System
│   ├── 📁 2-RDS/             # Relational Database Service
│   ├── 📁 3-Bucket/          # S3 Buckets
│   ├── 📁 4-ECR/             # Elastic Container Registry
│   ├── 📁 5-ECS/             # Elastic Container Service
│   ├── 📁 6-Builder/         # CodeBuild para CI/CD
│   ├── 📁 config/            # Configurações por ambiente
│   ├── 📁 Orquestrador/      # EC2 para orquestração
│   └── 📁 RemoteState/       # Gerenciamento de estado
├── 📁 Docker/                 # Containerização da aplicação
│   ├── 📁 BrunoCompleto/     # Implementação completa
│   ├── 📁 GLPI-Apache/       # Configuração com Apache
│   ├── 📁 GLPI-Git/          # Versões do GLPI
│   └── 📁 srv/               # Diretórios de serviço
├── 📁 GLPI/                   # Sistema GLPI
│   ├── 📄 Dockerfile         # Container do GLPI
│   ├── 📄 glpi-10.0.16.tgz   # Pacote de instalação
│   └── 📄 glpi-start.sh      # Script de inicialização
├── 📁 Diagrama/               # Diagramas de arquitetura
│   ├── 📄 Diagrama-G6-P20-v3.drawio  # Versão final
│   └── 📄 *.png, *.pdf       # Exportações
├── 📁 Entrega/                # Documentação final
│   ├── 📄 Proposta_Tecniva_P2-_G6.pdf
│   ├── 📄 Proposta_Comercial_P20-G6.pdf
│   └── 📄 Projeto_20_Grupo6.pptx
├── 📁 Documentacao/           # Arquivos de trabalho
├── 📁 Grupo/                  # Colaboração da equipe
└── 📄 README.md              # Este arquivo
```

## Tecnologias Utilizadas

### Cloud Computing
- **AWS** - Plataforma de nuvem principal
- **Terraform** - Infrastructure as Code
- **Docker** - Containerização
- **ECS Fargate** - Orquestração serverless de containers

### Aplicação
- **GLPI 10.0.16** - Sistema de gestão de TI
- **PHP 8.0+** - Runtime da aplicação
- **Apache HTTP Server** - Servidor web
- **MySQL 8.0** - Sistema de banco de dados

### DevOps e Automação
- **AWS CodeBuild** - CI/CD pipeline
- **GitHub** - Controle de versão
- **CloudWatch** - Monitoramento e logs
- **Systems Manager** - Gerenciamento de configuração

## Benefícios da Solução

### Performance
- **60% de redução** no tempo de resposta
- **CDN global** com CloudFront
- **Auto scaling** baseado em demanda
- **Load balancing** inteligente

### Disponibilidade
- **SLA de 99,9%** garantido
- **Multi-AZ deployment**
- **Backup automático** e disaster recovery
- **Monitoramento 24/7**

### Escalabilidade
- **Suporte a 10x mais usuários**
- **Scaling automático** de recursos
- **Arquitetura elástica**
- **Pay-as-you-use**

### Segurança
- **Criptografia** em trânsito e repouso
- **WAF** para proteção de aplicações
- **VPC** com isolamento de rede
- **IAM** com least privilege

### Custos
- **30% de redução** em TCO (3 anos)
- **Eliminação** de CAPEX
- **Otimização** de recursos
- **ROI de 160%** em 3 anos

## Guia de Início Rápido

### Pré-requisitos
```bash
# Instalar Terraform
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install terraform

# Instalar AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip && sudo ./aws/install

# Configurar credenciais AWS
aws configure
```

### Deploy da Infraestrutura
```bash
# 1. Clonar o repositório
git clone <repository-url>
cd AWS-Projeto-20

# 2. Configurar backend do Terraform
cd Terraform/RemoteState
terraform init && terraform apply

# 3. Deploy dos componentes
cd ../1-EFS && terraform init && terraform apply
cd ../2-RDS && terraform init && terraform apply
cd ../4-ECR && terraform init && terraform apply
cd ../5-ECS && terraform init && terraform apply
```

### Build e Deploy da Aplicação
```bash
# 1. Build da imagem Docker
cd Docker/BrunoCompleto
docker build -t glpi-app:latest .

# 2. Push para ECR
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin <account>.dkr.ecr.us-east-1.amazonaws.com
docker tag glpi-app:latest <account>.dkr.ecr.us-east-1.amazonaws.com/glpi-app:latest
docker push <account>.dkr.ecr.us-east-1.amazonaws.com/glpi-app:latest

# 3. Deploy no ECS
aws ecs update-service --cluster glpi-cluster --service glpi-service --force-new-deployment
```

## READMEs Específicos
- [Terraform - Infrastructure as Code](./Terraform/README.md)
- [Docker - Containerização](./Docker/README.md)
- [GLPI - Sistema Principal](./GLPI/README.md)
- [Diagramas - Arquitetura Visual](./Diagrama/README.md)
- [Entrega - Documentação Final](./Entrega/README.md)
- [Documentação - Arquivos de Trabalho](./Documentacao/README.md)
- [Grupo - Colaboração da Equipe](./Grupo/README.md)

## Equipe do Projeto

### Grupo 6 - Projeto 20
- **Cloud Treinamentos** - Oficina de Projetos 20
- **Período**: 2024
- **Foco**: Migração GLPI para AWS

### Contato
- **Repositório**: GitHub
- **Documentação**: Diretório `Entrega/`
- **Suporte**: Consultar READMEs específicos

---

**Projeto desenvolvido com ❤️ pelo Grupo 6 da Oficina de Projetos 20 - Cloud Treinamentos**
