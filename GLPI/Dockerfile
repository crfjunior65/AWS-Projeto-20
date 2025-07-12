# Usar a imagem oficial do PHP com Apache
FROM php:8.1-apache

# Atualiza os pacotes
RUN apt-get update && apt-get upgrade -y

## Instalar extensões necessárias para o GLPI
RUN apt-get update && apt-get install -y \
zlib1g-dev \
libpng-dev \
libjpeg-dev \
libfreetype6-dev \
libxml2-dev \
unzip \
git \
libpng-dev \
libjpeg-dev \
libfreetype6-dev \
zlib1g-dev \
libzip-dev \
unzip \
wget \
vim \
&& docker-php-ext-configure gd --with-freetype --with-jpeg \
&& docker-php-ext-install gd \
&& docker-php-ext-install mysqli \
&& docker-php-ext-install pdo pdo_mysql \
&& a2enmod rewrite \
&& rm -rf /var/lib/apt/lists/*

# Instalando o Composer (gerenciador de dependências PHP)
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Configura o MySQL (ajuste a senha)
#RUN mysql_secure_installation \
#  -u root \
#  -p sua_senha_forte

# Baixa e descompacta o GLPI (ajuste o caminho para o arquivo)
WORKDIR /var/www/html
RUN wget -O- https://github.com/glpi-project/glpi/releases/download/10.0.16/glpi-10.0.16.tgz | tar -zxv -C /var/www/html/

#RUN wget https://download.glpi-project.org/glpi-9.5.4.tar.gz \
#  && tar -xzvf glpi-9.5.4.tar.gz

# Configura as permissões (ajuste conforme necessário)
RUN chown -R www-data:www-data /var/www/html \
&& chmod -R 755 /var/www/html

# Configura o Apache (ajuste o DocumentRoot)
#COPY apache2.conf /etc/apache2/apache2.conf

# Executa o script de instalação do GLPI (ajuste o caminho para o script)
#####RUN php /var/www/html/install/install.php

# Exporta as variáveis de ambiente do GLPI (ajuste conforme necessário)
#ENV GLPI_DATABASE_SERVER=localhost \
#    GLPI_DATABASE_NAME=glpi \
#    GLPI_DATABASE_USER=root \
#    GLPI_DATABASE_PASSWORD=sua_senha_forte
RUN /etc/init.d/apache2 start
# Executa o Apache
#CMD ["apachectl", "-D", "FOREGROUND"]

WORKDIR /var/www/html/glpi

EXPOSE 80

CMD ["apache2-foreground"]
