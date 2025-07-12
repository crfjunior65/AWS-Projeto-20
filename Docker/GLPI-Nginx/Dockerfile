FROM nginx

# Install PHP and other required packages
RUN apt-get update && apt-get install -y php7.4-fpm php7.4-mysql php7.4-gd php7.4-ldap php7.4-curl php7.4-cli php7.4-xml mariadb-client

# Download and extract GLPI
RUN curl -L -o /tmp/glpi.tar.gz https://github.com/glpi-project/glpi/releases/download/9.5.7/glpi-9.5.7.tgz && \
    tar xzf /tmp/glpi.tar.gz -C /usr/share/nginx/html && \
    rm /tmp/glpi.tar.gz && \
    chown -R www-data:www-data /usr/share/nginx/html/glpi

# Configure NGINX to serve GLPI
COPY default.conf /etc/nginx/conf.d/default.conf

# Expose ports
EXPOSE 80

# Start NGINX and PHP-FPM
CMD ["nginx", "-g", "daemon off;"]