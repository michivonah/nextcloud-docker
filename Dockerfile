FROM debian:latest

# Update packages
RUN apt-get update

# Install required software
RUN apt-get install mc htop wget curl unzip systemctl apt-utils iproute2 -y

# Install webserver
RUN apt-get install apache2 -y
RUN systemctl enable apache2
RUN systemctl start apache2
RUN a2enmod ssl rewrite headers
RUN systemctl restart apache2

# Install php8.2 with required modules
RUN apt-get install lsb-release apt-transport-https ca-certificates software-properties-common -y
RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
RUN sh -c 'echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list'
RUN apt-get update
RUN apt-get install php8.2 libapache2-mod-php8.2 php8.2-curl php8.2-cli php8.2-mysql php8.2-gd php8.2-common php8.2-xml php8.2-intl php8.2-imagick php8.2-dev php8.2-common php8.2-mbstring php8.2-zip php8.2-soap php8.2-bz2 php8.2-bcmath php8.2-gmp php8.2-apcu libmagickcore-dev -y

# Change apache config
WORKDIR /etc/apache2/sites-available/
COPY apache-conf.conf .

# Set enviromental variables
ENV MEMORY_LIMIT 512M
ENV MAX_FILE_SIZE 10G
ENV PHP_TIMEZONE Europe/Zurich
ENV BASE_URL example.com

# Copy script
RUN mkdir /app
WORKDIR /app/
COPY entrypoint.sh .

# Create data location
RUN mkdir data

# Run container
ENTRYPOINT ["sh","entrypoint.sh"]