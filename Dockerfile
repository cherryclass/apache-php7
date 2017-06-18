FROM debian:stretch-slim
MAINTAINER Luc Frébourg
ENV DEBIAN_FRONTEND noninteractive


RUN apt-get update && apt-get -y upgrade && DEBIAN_FRONTEND=noninteractive apt-get -y install \
apache2 \
php7.0 \
curl \
lynx-cur \
libapache2-mod-php7.0 \
php7.0-fpm \
php7.0-mysql \
php7.0-curl \
php7.0-json \
php7.0-gd \
php7.0-mcrypt \
php7.0-msgpack \
php7.0-memcached \
php7.0-intl \
php7.0-sqlite3 \
php7.0-gmp \
php7.0-geoip \
php7.0-mbstring \
php7.0-xml \
php7.0-zip \
composer \
mcrypt \
git \
sudo \
nano \
ssh \
python-certbot-apache \
php-smbclient \
php-net-socket \
php-apcu

# Enable apache mods.
RUN a2enmod php7.0
RUN a2enmod rewrite
RUN a2enmod proxy_fcgi setenvif
RUN a2enconf php7.0-fpm
RUN a2enmod expires
RUN a2enmod ext_filter
RUN a2enmod headers

ADD php.ini /etc/php/7.0/apache2/php.ini

# Manually set up the apache environment variables
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid

ADD index.php var/www/index.php

RUN mkdir var/www/gitlab/
RUN a2ensite gitlab.conf



RUN chown -R www-data:www-data /var/www
RUN chsh -s /bin/bash www-data
RUN adduser www-data sudo

EXPOSE 80 443 110 143 145 22 25 53

# By default start up apache in the foreground, override with /bin/bash for interative.
CMD /usr/sbin/apache2ctl -D FOREGROUND

#sudo certbot --apache
