<!-- INSTALAR APT -->

apt-get update -y
apt-get upgrade -y

<!-- INSTALAR APACHE2-->

sudo apt isntall -y apache2 libapache2-mod-php php-soap pho-cas php php-{apcu,cli,common,curl,gd,imap,idap,mysql,xmlrpc,xml,mbstring,bcmath,intl,zip,bz2}
sudo apt-get install -y xz-utils bzip2 unzip curl
sudo apt install apache2
sudo systemctl enable apache2
sudo systemctl start apache2

<!-- REMOVER PACOTES NTP -->

apt purge ntp

<!-- INSTALAR OpennTPD -->

apt install -y openntpd
service openntpd stop
dpkg-reconfigure tzdata 

<!-- Depois da execução selecionar "America", em seguida time zona "São Paulo" -->


<!--ADICIONANDO O SERVIDOR -->

echo "servers pool.ntp.br" > /etc/openntpd/ntpd.conf
systemctl enable openntpd
systemctl start openntpd

<!-- BAIXAR GLPI -->

wget -O- https://github.com/glpi-project/glpi/releases/download/10.0.7/glpi-10.0.7.tgz | tar -zxv -C /var/www/html/

<!-- CONFIGURANDO PERMISSÕES DO GLPI -->

chown www-data: /var/www/html/glpi -Rf 
find /var/www/html/glpi -type d -exec chmod 755 {} \;
find /var/www/html/glpi -type f -exec chmod 644 {} \;

<!-- INSTALANDO O BANCO DE DADOS MYSQL -->

apt install -y mariadb-secdddrver
mysql_secure_installation

<!-- CRIAÇÃO DO BANCO E DO USUÁRIOGLPI -->

mysql -u root -p
       create database glpidb character set utf8;
       create user "glpi"@"localhost" identified by "glpi2024";
       grant all privileges on glpi.* to "glpi"@"localhost" with grant option;
       flush privileges;
       exit;

<!-- CRIAR AGENDADOS DE TAREFAS -->

echo -e "* *\t* * *\troot\tphp /var/www/html/glpi/front/cron.php" >> /etc/crontab
service cron restart
apt-get install php8.l-intl
apt-get install php8.l-gd
 
systemctl restart apache2

<!-- ULTIMO COMANDO DO GLPI -->

rm -Rf /var/www/html/glpi/install/install.php