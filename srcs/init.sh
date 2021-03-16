service mysql start

# Config Access
chown -R www-data /var/www/*
chmod -R 755 /var/www/*


# Generate website folder
mkdir /var/www/saichaitanya 
mv ./tmp/index.html /var/www/saichaitanya
mv ./tmp/hacker.jpg /var/www/saichaitanya
mv ./tmp/main.css /var/www/saichaitanya
#echo "" >> /var/www/saichaitanya/index.html

# SSL
mkdir /etc/nginx/ssl
openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/nginx/ssl/saichaitanya.pem -keyout /etc/nginx/ssl/saichaitanya.key -subj "/C=FR/ST=Rome/L=Rome/O=42 School/OU=saluru/CN=saichaitanya"

# Config NGINX
mv ./tmp/nginx-conf /etc/nginx/sites-available/saichaitanya
ln -s /etc/nginx/sites-available/saichaitanya /etc/nginx/sites-enabled/saichaitanya
rm -rf /etc/nginx/sites-enabled/default

# Configure a wordpress database
echo "CREATE DATABASE wordpress;"| mysql -u root --skip-password
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'localhost' WITH GRANT OPTION;"| mysql -u root --skip-password
echo "FLUSH PRIVILEGES;"| mysql -u root --skip-password
echo "update mysql.user set plugin='' where user='root';"| mysql -u root --skip-password

# DL phpmyadmin
mkdir /var/www/saichaitanya/phpmyadmin
wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz
tar -xvf phpMyAdmin-4.9.0.1-all-languages.tar.gz --strip-components 1 -C /var/www/saichaitanya/phpmyadmin
rm phpMyAdmin-4.9.0.1-all-languages.tar.gz
mv ./tmp/phpmyadmin.inc.php /var/www/saichaitanya/phpmyadmin/config.inc.php

# DL wordpress
cd /tmp/
wget -c https://wordpress.org/latest.tar.gz
tar -xvzf latest.tar.gz
mv wordpress/ /var/www/saichaitanya
mv /tmp/wp-config.php /var/www/saichaitanya/wordpress

service php7.3-fpm start
service nginx start
service mysql restart

cd ..

chmod 744 auto_on.sh
chmod 744 auto_off.sh

bash
