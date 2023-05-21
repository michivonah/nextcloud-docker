#!/bin/bash

# change PHP configuration
cd /etc/php/7.4/apache2/
#echo 'extension=mysql.so' >> php.ini
#echo 'extension=gd.so' >> php.ini
sed -i "s#memory_limit = 128M#memory_limit = 512M#g" php.ini
sed -i "s#post_max_size = 8M#post_max_size = 10G#g" php.ini
sed -i "s#upload_max_filesize = 2M#upload_max_filesize = 10G#g" php.ini