# Docker - Containerização da Aplicação GLPI

## Contexto do Diretório

Este diretório contém todas as configurações, scripts e arquivos necessários para containerizar o sistema GLPI (Gestão Livre de Parque de Informática) e seus componentes auxiliares. A containerização permite portabilidade, escalabilidade e facilita o deployment em diferentes ambientes.

### Finalidade Principal
- Containerizar a aplicação GLPI com todas suas dependências
- Criar imagens Docker otimizadas para produção
- Facilitar o deployment e escalabilidade da aplicação
- Padronizar o ambiente de execução

### Relação com Outros Componentes
- **Terraform**: Utiliza as imagens criadas aqui para provisionar no ECS/ECR
- **GLPI**: Implementa a containerização da aplicação base
- **Entrega**: Suporta os requisitos de deployment documentados

### Tecnologias/Linguagens Principais
- **Docker** - Containerização
- **Apache HTTP Server** - Servidor web
- **PHP** - Runtime da aplicação GLPI
- **Ubuntu 24.10** - Sistema operacional base
- **Bash Scripts** - Automação e configuração

## Estrutura de Arquivos

```
Docker/
├── BrunoCompleto/              # Implementação completa do container
│   ├── app_installation/       # Scripts de instalação da aplicação
│   ├── Projeto20G6-CICD/      # Pipeline CI/CD específico
│   ├── scripts/                # Scripts auxiliares
│   ├── upperplan-app-master/   # Código fonte da aplicação
│   ├── Dockerfile              # Definição da imagem principal
│   └── appspec.yml             # Especificação para CodeDeploy
├── GLPI-Apache/                # Configuração GLPI com Apache
├── GLPI-Git/                   # Versões do GLPI do repositório Git
│   ├── glpi/                   # Versão atual do GLPI
│   └── glpi-Old/               # Versão anterior para referência
├── GLPI-Nginx/                 # Configuração GLPI com Nginx
├── sdbrasil/                   # Configurações específicas
├── srv/                        # Diretórios de serviço
│   ├── glpi/                   # Dados do GLPI
│   └── mariadb/                # Dados do MariaDB
├── var/                        # Diretórios variáveis
│   └── www/                    # Documentos web
├── Dockerfile                  # Dockerfile principal
├── docker-compose.yml          # Orquestração local
├── glpi-start.sh              # Script de inicialização
└── setup-glpi.sh              # Script de configuração
```

## Fluxo de Trabalho

### 1. Build da Imagem
```bash
# Build da imagem principal
docker build -t glpi-app:latest .

# Build com tag específica
docker build -t glpi-app:v1.0.0 -f BrunoCompleto/Dockerfile .
```

### 2. Execução Local
```bash
# Executar container individual
docker run -d -p 80:80 --name glpi-container glpi-app:latest

# Executar com docker-compose
docker-compose up -d
```

### 3. Push para Registry
```bash
# Tag para ECR
docker tag glpi-app:latest 123456789012.dkr.ecr.us-east-1.amazonaws.com/glpi-app:latest

# Push para ECR
docker push 123456789012.dkr.ecr.us-east-1.amazonaws.com/glpi-app:latest
```

### Dependências Importantes
- **Docker Engine** >= 20.10
- **Docker Compose** >= 2.0
- **AWS CLI** para push no ECR
- **Acesso ao ECR** configurado

## Configuração

### Dockerfile Principal (BrunoCompleto/Dockerfile)
```dockerfile
FROM public.ecr.aws/ubuntu/ubuntu:24.10

# Configurações de ambiente
ENV DEBIAN_FRONTEND=noninteractive

# Instalação de dependências
RUN apt-get update && apt-get install -y \
    apache2 \
    php \
    php-mysql \
    php-curl \
    php-gd \
    php-xml \
    && rm -rf /var/lib/apt/lists/*

# Configuração do Apache
RUN a2enmod rewrite
COPY apache2.conf /etc/apache2/apache2.conf

# Instalação do GLPI
WORKDIR /var/www/glpi
COPY glpi-10.0.16.tgz .
RUN tar -xzf glpi-10.0.16.tgz --strip-components=1

EXPOSE 80
CMD ["apache2ctl", "-D", "FOREGROUND"]
```

### Variáveis de Ambiente
```bash
# Configurações do banco de dados
DB_HOST=rds-endpoint.region.rds.amazonaws.com
DB_NAME=glpi
DB_USER=glpi_user
DB_PASS=secure_password

# Configurações da aplicação
GLPI_LANG=pt_BR
GLPI_TIMEZONE=America/Sao_Paulo
```

### Pré-requisitos de Instalação
1. **Docker** instalado e configurado
2. **Docker Compose** para orquestração local
3. **AWS CLI** para integração com ECR
4. **Credenciais AWS** para push de imagens

## Boas Práticas

### 1. Otimização de Imagem
- Uso de imagens base oficiais e leves
- Multi-stage builds quando necessário
- Limpeza de cache e arquivos temporários
- Minimização de layers

### 2. Segurança
- Execução com usuário não-root quando possível
- Scanning de vulnerabilidades nas imagens
- Uso de secrets para informações sensíveis
- Atualização regular das imagens base

### 3. Performance
- Cache de layers do Docker
- Otimização da ordem dos comandos no Dockerfile
- Uso de .dockerignore para excluir arquivos desnecessários
- Configuração adequada de recursos

### 4. Monitoramento
- Health checks configurados
- Logs estruturados
- Métricas de container
- Integração com CloudWatch

## Comandos Úteis

### Build e Test
```bash
# Build com cache
docker build --cache-from glpi-app:latest -t glpi-app:new .

# Test da imagem
docker run --rm -it glpi-app:latest /bin/bash

# Verificar logs
docker logs glpi-container
```

### Debugging
```bash
# Executar shell no container
docker exec -it glpi-container /bin/bash

# Verificar processos
docker exec glpi-container ps aux

# Verificar configuração do Apache
docker exec glpi-container apache2ctl -S
```

### Limpeza
```bash
# Remover containers parados
docker container prune

# Remover imagens não utilizadas
docker image prune

# Limpeza completa
docker system prune -a
```

## Configurações Específicas

### Apache Configuration
- Módulo rewrite habilitado
- DocumentRoot configurado para /var/www/glpi
- PHP configurado com extensões necessárias
- Logs direcionados para stdout/stderr

### PHP Configuration
- Extensões: mysql, curl, gd, xml, intl, mbstring
- Memory limit adequado para GLPI
- Upload de arquivos configurado
- Timezone configurado

### GLPI Configuration
- Configuração de banco via variáveis de ambiente
- Diretórios de dados persistentes
- Configuração de cache
- Integração com EFS para arquivos

## Troubleshooting

### Problemas Comuns
1. **Erro de conexão com banco**: Verificar variáveis de ambiente
2. **Permissões de arquivo**: Verificar ownership dos diretórios
3. **Módulos PHP**: Verificar se todas as extensões estão instaladas
4. **Apache não inicia**: Verificar configuração e logs

### Logs Importantes
- Apache: `/var/log/apache2/`
- PHP: `/var/log/php/`
- GLPI: `/var/www/glpi/files/_log/`

## Integração com AWS

### ECR (Elastic Container Registry)
- Repositório para armazenar imagens
- Scanning automático de vulnerabilidades
- Lifecycle policies para gerenciar versões

### ECS (Elastic Container Service)
- Orquestração de containers em produção
- Auto scaling baseado em métricas
- Integração com ALB para load balancing

### CodeBuild
- Build automático das imagens
- Integração com pipeline CI/CD
- Testes automatizados

## Contatos e Suporte

Para dúvidas sobre containerização:
- Equipe: Grupo 6 - Projeto 20
- Documentação GLPI: https://glpi-project.org/
- Docker Hub: https://hub.docker.com/
