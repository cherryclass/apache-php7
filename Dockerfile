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
git \
sudo \
nano \
ssh \
gitolite3 \
gitweb

#gitolite https://www.vultr.com/docs/setup-git-repositories-with-gitolite-on-debian-wheezy
#owncloud https://falstaff.agner.ch/2013/02/27/deploy-owncloud-from-source-using-git/
#let s encrytp https://www.digitalocean.com/community/tutorials/how-to-secure-apache-with-let-s-encrypt-on-debian-8

# Enable apache mods.
RUN a2enmod php7.0
RUN a2enmod rewrite

# Update the PHP.ini file, enable <? ?> tags and quieten logging.
RUN sed -i "s/short_open_tag = Off/short_open_tag = On/" /etc/php/7.0/apache2/php.ini
RUN sed -i "s/error_reporting = .*$/error_reporting = E_ERROR | E_WARNING | E_PARSE/" /etc/php/7.0/apache2/php.ini

# Manually set up the apache environment variables
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid

RUN mkdir var/www/adminer/
RUN mkdir var/www/owncloud/
RUN mkdir var/www/owncloud/config
RUN mkdir var/www/owncloud/data
RUN mkdir var/www/owncloud/apps
RUN mkdir var/www/owncloud/3rdparty

ADD index.php var/www/index.php
ADD /owncloud10 var/www/owncloud/
ADD adminer-4.3.1-mysql.php var/www/adminer/index.php
ADD 000-default.conf /etc/apache2/sites-enabled/000-default.conf

RUN chown -R www-data:www-data /var/www
RUN chsh -s /bin/bash www-data

EXPOSE 80 443 110 143 145 22 25 53

# By default start up apache in the foreground, override with /bin/bash for interative.
CMD /usr/sbin/apache2ctl -D FOREGROUND
