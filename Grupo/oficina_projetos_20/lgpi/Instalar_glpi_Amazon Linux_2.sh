#!/bin/bash

# Atualizar pacotes do sistema
sudo yum update -y

# Instalar Apache, MariaDB e PHP
sudo amazon-linux-extras install php8.0 -y
sudo amazon-linux-extras enable php7.4 -y
sudo yum install php php-mysqlnd php-gd php-xml php-curl php-mbstring php-zip php-intl –y
sudo yum clean metadata -y
sudo yum install httpd -y

# Adicionar o repositório MariaDB 10.6
sudo tee /etc/yum.repos.d/MariaDB.repo <<EOF
# MariaDB 10.6 CentOS repository list - created 2024-09-17 09:55 UTC
# https://mariadb.org/download/
[mariadb]
name = MariaDB
baseurl = http://yum.mariadb.org/10.6/centos7-amd64
gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB
gpgcheck=1
EOF

# Instalar MariaDB 10.6
sudo yum install MariaDB-server MariaDB-client -y

# Iniciar e habilitar o Apache e MariaDB
sudo systemctl start httpd
sudo systemctl enable httpd
sudo systemctl start mariadb
sudo systemctl enable mariadb

# Configurar MariaDB (criar banco de dados e usuário para GLPI)
sudo mysql -e "CREATE DATABASE glpi DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
sudo mysql -e "CREATE USER 'glpiuser'@'localhost' IDENTIFIED BY 'sua_senha_forte';"
sudo mysql -e "GRANT ALL PRIVILEGES ON glpi.* TO 'glpiuser'@'localhost';"
sudo mysql -e "FLUSH PRIVILEGES;"

# Executar a configuração segura do MySQL
sudo mysql_secure_installation <<EOF

y
sua_senha_root
sua_senha_root
y
y
y
y
EOF

# Baixar e instalar o GLPI
wget https://github.com/glpi-project/glpi/releases/download/10.0.9/glpi-10.0.9.tgz
tar -xzf glpi-10.0.9.tgz
sudo mv glpi /var/www/html/
sudo chown -R apache:apache /var/www/html/glpi
sudo chmod -R 755 /var/www/html/glpi

# Ajustar o SELinux (se estiver ativo)
if selinuxenabled; then
    sudo chcon -R -t httpd_sys_rw_content_t /var/www/html/glpi
fi

# Configurar o Apache
echo "<VirtualHost *:80>
    DocumentRoot /var/www/html/glpi
    <Directory /var/www/html/glpi>
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>" | sudo tee /etc/httpd/conf.d/glpi.conf

# Reiniciar o Apache
sudo systemctl restart httpd

# Finalização
echo "Instalação do GLPI concluída. Acesse o GLPI através do endereço IP do servidor para concluir a configuração via interface web."
