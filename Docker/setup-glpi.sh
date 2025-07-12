#!/bin/bash

# Variáveis do GLPI
GLPI_PATH="/var/www/html/glpi"
GLPI_CONFIG_FILE="$GLPI_PATH/config/config_db.php"

# Verificar se o arquivo de configuração já existe
if [ ! -f $GLPI_CONFIG_FILE ]; then
    echo "Iniciando a configuração do GLPI..."

    # Copiar o arquivo de configuração de exemplo
    cp $GLPI_PATH/config/config_db.php.dist $GLPI_CONFIG_FILE

    # Substituir as configurações do banco de dados com base nas variáveis de ambiente
    sed -i "s/localhost/$GLPI_DB_HOST/" $GLPI_CONFIG_FILE
    sed -i "s/glpi/$GLPI_DB_NAME/" $GLPI_CONFIG_FILE
    sed -i "s/glpiuser/$GLPI_DB_USER/" $GLPI_CONFIG_FILE
    sed -i "s/glpipassword/$GLPI_DB_PASSWORD/" $GLPI_CONFIG_FILE

    # Criar as pastas necessárias para o GLPI
    mkdir -p $GLPI_PATH/files/_log
    mkdir -p $GLPI_PATH/files/_dumps
    mkdir -p $GLPI_PATH/files/_sessions
    mkdir -p $GLPI_PATH/files/_cron
    mkdir -p $GLPI_PATH/files/_cache
    mkdir -p $GLPI_PATH/files/_tmp
    mkdir -p $GLPI_PATH/files/_rss
    mkdir -p $GLPI_PATH/files/_uploads

    # Ajustar permissões das pastas
    chown -R www-data:www-data $GLPI_PATH/files
    chmod -R 755 $GLPI_PATH/files

    # Rodar a CLI do GLPI para configurar o idioma
    php $GLPI_PATH/bin/console glpi:system:language --set=pt_BR

    # Instalação automática do GLPI
    echo "Instalando o GLPI via CLI..."
    php $GLPI_PATH/bin/console db:install \
        --db-host=$GLPI_DB_HOST \
        --db-name=$GLPI_DB_NAME \
        --db-user=$GLPI_DB_USER \
        --db-password=$GLPI_DB_PASSWORD \
        --default-language=pt_BR \
        --force

    echo "GLPI instalado com sucesso!"
else
    echo "GLPI já está configurado."
fi

# Iniciar o Apache
echo "Iniciando o Apache..."
apache2-foreground


2

#!/bin/bash

# Verificar se o arquivo de configuração já existe
if [ ! -f /var/www/html/glpi/config/config_db.php ]; then
    echo "Configurando GLPI com o banco de dados RDS..."

    # Copiar o arquivo de exemplo para o arquivo real de configuração
    cp /var/www/html/glpi/config/config_db.php.dist /var/www/html/glpi/config/config_db.php

    # Substituir as configurações padrão pelo valor das variáveis de ambiente
    sed -i "s/localhost/$GLPI_DB_HOST/" /var/www/html/glpi/config/config_db.php
    sed -i "s/glpi/$GLPI_DB_NAME/" /var/www/html/glpi/config/config_db.php
    sed -i "s/glpiuser/$GLPI_DB_USER/" /var/www/html/glpi/config/config_db.php
    sed -i "s/glpipassword/$GLPI_DB_PASSWORD/" /var/www/html/glpi/config/config_db.php

    echo "Configuração do GLPI concluída."

    # Rodar a CLI do GLPI para configurar o idioma
    php /var/www/html/glpi/bin/console glpi:system:language --set=pt_BR

    # Configurar as pastas compartilhadas
    mkdir -p /var/www/html/glpi/files/_log
    mkdir -p /var/www/html/glpi/files/_dumps
    mkdir -p /var/www/html/glpi/files/_sessions
    mkdir -p /var/www/html/glpi/files/_cron
    mkdir -p /var/www/html/glpi/files/_cache
    mkdir -p /var/www/html/glpi/files/_tmp
    mkdir -p /var/www/html/glpi/files/_rss
    mkdir -p /var/www/html/glpi/files/_uploads

    # Garantir que as permissões das pastas estão corretas
    chown -R www-data:www-data /var/www/html/glpi/files/
    chmod -R 755 /var/www/html/glpi/files/

    echo "Configuração das pastas concluída."
else
    echo "GLPI já está configurado."
fi

# Iniciar o Apache
apache2-foreground
