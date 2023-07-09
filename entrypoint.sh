#!/bin/bash

# download nextcloud
cd /var/www/
mkdir nextcloud
cd /var/www/nextcloud/
wget -O nextcloud.zip https://download.nextcloud.com/server/releases/latest.zip
unzip nextcloud.zip
rm nextcloud.zip
chown -R www-data:www-data nextcloud
chmod -R 755 nextcloud

# set privileges for data folder
cd /app/
chown -R www-data:www-data data
chmod -R 755 data

# change webserver configuration
cd /etc/apache2/sites-available/
sed -i 's#YOURDOMAIN#"'"$BASE_URL"'"#g' apache-conf.conf
a2ensite apache-conf.conf
systemctl restart apache2

# change PHP configuration
cd /etc/php/8.2/apache2/

sed -i 's#memory_limit = 128M#memory_limit = "'"$MEMORY_LIMIT"'"#g' php.ini
sed -i 's#upload_max_filesize = 2M#upload_max_filesize = "'"$MAX_FILE_SIZE"'"#g' php.ini
sed -i 's#post_max_size = 8M#post_max_size = "'"$MAX_FILE_SIZE"'"#g' php.ini
sed -i "s#max_execution_time = 30#max_execution_time = 300#g" php.ini
sed -i 's#;date.timezone =#date.timezone = "'"$PHP_TIMEZONE"'"#g' php.ini
sed -i "s#output_buffering = 4096#output_buffering = Off#g" php.ini
sed -i "s#;zend_extension=opcache#zend_extension=opcache#g" php.ini

sed -i "s#;opcache.enable=1#opcache.enable = 1#g" php.ini
sed -i "s#;opcache.interned_strings_buffer=8#opcache.interned_strings_buffer = 8#g" php.ini
sed -i "s#;opcache.max_accelerated_files=10000#opcache.max_accelerated_files = 10000#g" php.ini
sed -i "s#;opcache.memory_consumption=128#opcache.memory_consumption = 512#g" php.ini
sed -i "s#;opcache.save_comments=1#opcache.save_comments = 1#g" php.ini
sed -i "s#;opcache.revalidate_freq=2#opcache.revalidate_freq = 1#g" php.ini

# Restart webserver
#systemctl restart apache2
/etc/init.d/apache2 restart

sh