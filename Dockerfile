FROM php:8.5-apache

# install packages: supervisor, mysql server and utilities
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        supervisor \
        mariadb-server \
        pwgen

RUN docker-php-ext-install pdo_mysql mysqli

WORKDIR /var/www/html

# Copy project files
COPY . .

# copy entrypoint
RUN mv .andasy/entrypoint.sh /usr/local/bin/entrypoint.sh
# expose HTTP port (MySQL port remains internal)
EXPOSE 80


ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
