# nextcloud-docker
A ready-to-use docker image for nextcloud

GitHub: [https://github.com/michivonah/nextcloud-docker](https://github.com/michivonah/nextcloud-docker)

Docker Hub: [https://hub.docker.com/r/michivonah/nextcloud](https://hub.docker.com/r/michivonah/nextcloud)

## Table of contents
- [Self host](#self-host-nextcloud-with-docker)
- [Docker run](#docker-run)
- [Docker compose](#docker-compose)
- [Build docker image](#build-docker-image)

# Self host nextcloud with docker
## Docker run
Run container
```bash
docker run -itd --name nextcloud michivonah/nextcloud
```

Run container with mariadb database
```bash
docker run
```

You're done! Now visit http://localhost:8080 in your browser and configure nextcloud

## Docker compose
Copy following yml into a file called ```docker-compose.yml```
```yml
version: '3.9'
services:
    app:
        container_name: nextcloud
        ports:
            - '8080:80'
        volumes:
            - '/path/to/directory:/var/www/html'
        restart: unless-stopped
        environment:
            - MEMORY_LIMIT=512M
        networks:
            - nextcloudNET
        image: michivonah/nextcloud
    db:
        container_name: mariadb
        volumes:
            - '/path/to/database:/var/lib/mysql'
        restart: unless-stopped
        environment:
            - MARIADB_ROOT_PASSWORD=nextcloud
            - MARIADB_DATABASE=nextcloud
            - MARIADB_USER=nextcloud
            - MARIADB_PASSWORD=nextcloud
        networks:
            - nextcloudNET
        image: mariadb
networks:
  nextcloudNET:
    name: nextcloudNET
```

Run following command to start up the containers
```bash
docker-compose up -d
```

You're done! Now visit http://localhost:8080 in your browser and configure nextcloud

## Build docker image
Clone git repo
```bash
git clone https://github.com/michivonah/nextcloud-docker.git
```

Open directory
```bash
cd nextcloud-docker
```

Build image
```bash
docker build -t nextcloud-docker:latest .
```

Run container
```bash
docker run
```

> Please note that you need a running mariadb instance

# Sources
- https://www.howtoforge.com/how-to-install-nextcloud-on-debian-11/
- https://computingforgeeks.com/how-to-install-and-configure-nextcloud-on-debian/
- https://nextcloud.com/install/#instructions-server
- https://github.com/michivonah/helpdesk
- https://github.com/michivonah/moodle-docker