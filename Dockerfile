FROM debian:stretch-slim

MAINTAINER Luc Frébourg

ENV DEBIAN_FRONTEND noninteractive

#install stuff
RUN (apt-get update && apt-get upgrade -y -q && apt-get dist-upgrade -y -q && apt-get -y -q autoclean && apt-get -y -q autoremove)
RUN apt-get install --no-install-recommends --no-install-suggests -y \
	apt-utils \
 	apache2 \
	php7.0 \
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
	php7.0-zip\
	sudo \
	nano\
	ssh 
	

RUN mkdir var/www/cherryclass/adminer/
RUN mkdir var/www/cherryclass/owncloud/

ADD adminer-4.3.1-mysql.php var/www/cherryclass/adminer/adminer.php
ADD 000-default.conf /etc/apache2/sites-available/000-default.conf

#ADD opcache.ini /etc/php/mods-available/opcache.ini
#opcache.memory_consumption=512
#opcache.revalidate_freq=60
#opcache.validate_timestamps=1
#opcache.max_accelerated_files=5000

#WARNING - not working on bluemix with bx ic run, need to put -p or create container with web console.
EXPOSE 80 443 110 143 145 22 25 53
