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
