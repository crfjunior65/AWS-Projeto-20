# GLPI - Sistema de Gestão de Parque de Informática

## Contexto do Diretório

Este diretório contém os arquivos, configurações e scripts relacionados ao GLPI (Gestão Livre de Parque de Informática), um sistema open-source para gestão de ativos de TI, help desk e inventário. O GLPI é a aplicação principal do projeto, sendo migrada para a nuvem AWS.

### Finalidade Principal
- Hospedar os arquivos de instalação e configuração do GLPI
- Fornecer scripts de instalação automatizada
- Manter configurações específicas para o ambiente AWS
- Servir como base para a containerização

### Relação com Outros Componentes
- **Docker**: Utiliza os arquivos deste diretório para criar containers
- **Terraform**: Provisiona infraestrutura para hospedar o GLPI
- **Entrega**: Implementa os requisitos funcionais documentados

### Tecnologias/Linguagens Principais
- **GLPI** v10.0.16 - Sistema de gestão de TI
- **PHP** - Linguagem de programação principal
- **Apache HTTP Server** - Servidor web
- **MySQL/MariaDB** - Sistema de banco de dados
- **Bash Scripts** - Automação de instalação

## Estrutura de Arquivos

```
GLPI/
├── var/
│   └── www/
│       └── html/               # Documentos web do Apache
├── Dockerfile                  # Container do GLPI
├── apache2.conf               # Configuração do Apache
├── glpi-10.0.16.zip           # Pacote de instalação do GLPI
├── glpi-10.0.16.tgz           # Pacote compactado alternativo
├── glpi-10.0.16.tar.gz        # Pacote tar.gz
├── Direto-glpi-10.0.16.tgz    # Pacote direto
├── glpi-start.sh              # Script de inicialização
├── Instalação_GLPI.sh         # Script de instalação
├── install_glpi_comando.sh    # Script de instalação via comando
├── Install.sdbrasil           # Configuração específica
└── Script de Instalação do GLPI.md  # Documentação de instalação
```

## Fluxo de Trabalho

### 1. Instalação Manual
```bash
# Extrair arquivos do GLPI
tar -xzf glpi-10.0.16.tgz -C /var/www/

# Configurar permissões
chown -R www-data:www-data /var/www/glpi
chmod -R 755 /var/www/glpi

# Executar instalação
./Instalação_GLPI.sh
```

### 2. Instalação Automatizada
```bash
# Executar script de instalação completa
./install_glpi_comando.sh

# Inicializar serviços
./glpi-start.sh
```

### 3. Configuração via Web
1. Acessar http://servidor/glpi
2. Seguir wizard de instalação
3. Configurar conexão com banco de dados
4. Criar usuário administrador

### Dependências Importantes
- **Apache** >= 2.4
- **PHP** >= 8.0 com extensões: mysql, curl, gd, xml, intl, mbstring
- **MySQL/MariaDB** >= 5.7
- **Extensões PHP**: bz2, zip, exif, ldap, opcache

## Configuração

### Requisitos do Sistema
```bash
# PHP Extensions obrigatórias
php-curl php-gd php-intl php-mysql php-xml

# PHP Extensions opcionais (recomendadas)
php-bz2 php-phar php-zip php-exif php-ldap php-opcache php-mbstring
```

### Configuração do Apache
```apache
# /etc/apache2/sites-available/glpi.conf
<VirtualHost *:80>
    ServerName glpi.exemplo.com
    DocumentRoot /var/www/glpi
    
    <Directory /var/www/glpi>
        AllowOverride All
        Require all granted
    </Directory>
    
    ErrorLog ${APACHE_LOG_DIR}/glpi_error.log
    CustomLog ${APACHE_LOG_DIR}/glpi_access.log combined
</VirtualHost>
```

### Configuração do Banco de Dados
```sql
-- Criar banco de dados
CREATE DATABASE glpi CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Criar usuário
CREATE USER 'glpi_user'@'%' IDENTIFIED BY 'senha_segura';
GRANT ALL PRIVILEGES ON glpi.* TO 'glpi_user'@'%';
FLUSH PRIVILEGES;
```

### Variáveis de Ambiente
```bash
# Configurações do banco
export DB_HOST="rds-endpoint.region.rds.amazonaws.com"
export DB_NAME="glpi"
export DB_USER="glpi_user"
export DB_PASS="senha_segura"

# Configurações da aplicação
export GLPI_LANG="pt_BR"
export GLPI_TIMEZONE="America/Sao_Paulo"
```

## Boas Práticas

### 1. Segurança
- Configurar HTTPS em produção
- Usar senhas fortes para banco de dados
- Configurar backup automático
- Manter sistema atualizado
- Configurar firewall adequadamente

### 2. Performance
- Configurar cache do PHP (OPcache)
- Otimizar configurações do MySQL
- Usar CDN para arquivos estáticos
- Configurar compressão gzip
- Monitorar uso de recursos

### 3. Backup e Recuperação
- Backup regular do banco de dados
- Backup dos arquivos de configuração
- Backup dos arquivos enviados pelos usuários
- Testar procedimentos de recuperação
- Documentar processo de restore

### 4. Monitoramento
- Logs de aplicação e sistema
- Métricas de performance
- Alertas para problemas críticos
- Monitoramento de espaço em disco
- Verificação de integridade dos dados

## Scripts de Instalação

### install_glpi_comando.sh
```bash
#!/bin/bash
# Script de instalação automatizada do GLPI

# Atualizar sistema
apt-get update

# Instalar Apache e PHP
apt-get install -y apache2 php php-mysql php-curl php-gd php-xml

# Baixar e extrair GLPI
wget https://github.com/glpi-project/glpi/releases/download/10.0.16/glpi-10.0.16.tgz
tar -xzf glpi-10.0.16.tgz -C /var/www/

# Configurar permissões
chown -R www-data:www-data /var/www/glpi
chmod -R 755 /var/www/glpi

# Habilitar site
a2ensite glpi
systemctl reload apache2
```

### glpi-start.sh
```bash
#!/bin/bash
# Script de inicialização do GLPI

# Verificar serviços
systemctl start apache2
systemctl start mysql

# Verificar conectividade com banco
php -r "
$pdo = new PDO('mysql:host=$DB_HOST;dbname=$DB_NAME', '$DB_USER', '$DB_PASS');
echo 'Conexão com banco OK\n';
"

# Inicializar GLPI se necessário
if [ ! -f /var/www/glpi/config/config_db.php ]; then
    echo "Primeira execução - configurar GLPI via web interface"
fi
```

## Configurações Específicas AWS

### Integração com RDS
- Endpoint do RDS configurado via variáveis de ambiente
- SSL/TLS habilitado para conexões seguras
- Backup automático configurado no RDS
- Multi-AZ para alta disponibilidade

### Integração com EFS
- Diretório `/var/www/glpi/files` montado no EFS
- Compartilhamento de arquivos entre instâncias
- Backup automático do EFS
- Criptografia em trânsito e repouso

### Integração com S3
- Backup de arquivos para S3
- Armazenamento de logs no S3
- Versionamento de backups
- Lifecycle policies configuradas

## Troubleshooting

### Problemas Comuns

#### 1. Erro de Conexão com Banco
```bash
# Verificar conectividade
telnet $DB_HOST 3306

# Testar credenciais
mysql -h $DB_HOST -u $DB_USER -p$DB_PASS $DB_NAME
```

#### 2. Problemas de Permissão
```bash
# Corrigir permissões
chown -R www-data:www-data /var/www/glpi
chmod -R 755 /var/www/glpi
chmod -R 777 /var/www/glpi/files
```

#### 3. Extensões PHP Faltando
```bash
# Verificar extensões instaladas
php -m | grep -E "(mysql|curl|gd|xml)"

# Instalar extensões faltando
apt-get install php-extensao
```

### Logs Importantes
- Apache: `/var/log/apache2/`
- PHP: `/var/log/php/`
- GLPI: `/var/www/glpi/files/_log/`
- Sistema: `/var/log/syslog`

## Funcionalidades Principais

### Gestão de Ativos
- Inventário de hardware e software
- Controle de licenças
- Gestão de contratos
- Acompanhamento de garantias

### Help Desk
- Sistema de tickets
- Categorização de chamados
- SLA e escalação
- Base de conhecimento

### Administração
- Gestão de usuários e grupos
- Controle de permissões
- Relatórios e estatísticas
- Configurações globais

## Integração e Customização

### Plugins Disponíveis
- Integração com Active Directory/LDAP
- Conectores para monitoramento
- Plugins de relatórios avançados
- Integrações com ferramentas externas

### API REST
- Endpoints para integração
- Autenticação via token
- Operações CRUD completas
- Documentação da API disponível

## Contatos e Suporte

Para suporte técnico do GLPI:
- Documentação oficial: https://glpi-project.org/
- Comunidade: https://forum.glpi-project.org/
- GitHub: https://github.com/glpi-project/glpi
- Equipe do projeto: Grupo 6 - Projeto 20
