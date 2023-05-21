#!/bin/bash

# configure apache
cd /etc/apache2/sites-available/
sed -i "s#var/www/html#var/www/html/nextcloud#g" 000-default.conf
systemctl restart apache2

# change PHP configuration
cd /etc/php/8.2/apache2/
#echo 'extension=mysql.so' >> php.ini
#echo 'extension=gd.so' >> php.ini
sed -i "s#memory_limit = 128M#memory_limit = 512M#g" php.ini
sed -i "s#post_max_size = 8M#post_max_size = 10G#g" php.ini
sed -i "s#upload_max_filesize = 2M#upload_max_filesize = 10G#g" php.ini