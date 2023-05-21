FROM debian:latest

RUN apt-get update

# Install required software
RUN apt-get install mc htop wget curl unzip -y

# Install webserver
RUN apt-get install apache2 libapache2-mod-php -y

# Install php with required modules
RUN apt-get install php php-gd php-curl php-zip php-dom php-xml php-simplexml php-mbstring php-bcmath php-fpm php-mysql php-intl php-ldap php-gd php-cli php-bz2 php-pgsql php-opcache php-soap php-cgi -y

# Install mariadb
RUN apt-get install mariadb-server mariadb-client -y

# Download nextcloud
WORKDIR /var/www/html/
RUN wget -O nextcloud.zip https://download.nextcloud.com/server/releases/latest.zip
RUN unzip nextcloud.zip
RUN rm nextcloud.zip

# Set enviromental variables
ENV DBHOST nextcloudDB
ENV DBPORT 3306
ENV DBNAME nextcloud
ENV DBUSER nextcloud
ENV DBPASSWORD nextcloud

# Run container
#CMD ["sh","entrypoint.sh"]
CMD ["sh"]