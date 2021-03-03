mv ./var/www/saichaitanya/index.html ./tmp
cd ./etc/nginx/sites-enabled
sed -i 's/autoindex off/autoindex on/' saichaitanya
cd
cd ..
nginx -s  reload
echo "\nautoindex is off\n"
