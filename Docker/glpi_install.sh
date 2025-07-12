#!/bin/bash

# Aguarda o banco de dados estar acessível (ajustar tempo conforme necessário)
echo "Aguardando banco de dados estar acessível..."
sleep 15

# Executa a instalação do GLPI via CLI
php ${GLPI_INSTALL_DIR}/bin/console db:install \
    --db-host=seu-mysql-host \
    --db-name=seu-banco-de-dados \
    --db-user=seu-usuario \
    --db-password=sua-senha \
    --lang=${GLPI_LANGUAGE} \
    --force

# Exibe uma mensagem de conclusão
echo "Instalação do GLPI concluída!"
