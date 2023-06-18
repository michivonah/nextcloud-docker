#!/bin/bash

# change PHP configuration
cd /etc/php/8.2/apache2/

sed -i 's#memory_limit = 128M#memory_limit = "'"$MEMORY_LIMIT"'"#g' php.ini
sed -i 's#upload_max_filesize = 2M#upload_max_filesize = "'"$MAX_FILE_SIZE"'"#g' php.ini
sed -i 's#post_max_size = 8M#post_max_size = "'"$MAX_FILE_SIZE"'"#g' php.ini
sed -i "s#max_execution_time = 30#max_execution_time = 300#g" php.ini
sed -i 's#;date.timezone =#date.timezone = "'"$PHP_TIMEZONE"'"#g' php.ini
sed -i "s#output_buffering = 4096#output_buffering = Off#g" php.ini
sed -i "s#;zend_extension=opcache#zend_extension=opcache#g" php.ini

echo '; OPCACHE' >> php.ini
echo 'opcache.enable = 1' >> php.ini
echo 'opcache.interned_strings_buffer = 8' >> php.ini
echo 'opcache.max_accelerated_files = 10000' >> php.ini
echo 'opcache.memory_consumption = 512' >> php.ini
echo 'opcache.save_comments = 1' >> php.ini
echo 'opcache.revalidate_freq = 1' >> php.ini

# Restart webserver
#systemctl restart apache2
/etc/init.d/apache2 restart