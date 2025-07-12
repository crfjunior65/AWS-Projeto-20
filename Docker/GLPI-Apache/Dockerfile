# Use uma imagem base PHP com Apache
FROM php:8.1-apache

# Instalar extensões necessárias para o GLPI
RUN apt-get update && apt-get install -y \
    mariadb-client \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \
    zlib1g-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd mysqli pdo pdo_mysql zip

# Ativar o mod_rewrite do Apache
RUN a2enmod rewrite

# Definir a variável de ambiente para o diretório de trabalho
WORKDIR /var/www/html

# Baixar e descompactar a última versão do GLPI
RUN curl -L https://github.com/glpi-project/glpi/releases/download/10.0.0/glpi-10.0.0.tgz | tar zx --strip 1

# Definir permissões corretas
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Expor a porta 80
EXPOSE 80

# Comando de inicialização do Apache
CMD ["apache2-foreground"]
