mv ./tmp/index.html ./var/www/saichaitanya
cd ./etc/nginx/sites-enabled
sed -i 's/autoindex on/autoindex off/' saichaitanya
cd
cd ..
nginx -s  reload
echo "autoindex is off"
