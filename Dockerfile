FROM php:7.0-apache

MAINTAINER Luc Frébourg

ENV DEBIAN_FRONTEND noninteractive

#install stuff
RUN (apt-get update && apt-get upgrade -y -q && apt-get dist-upgrade -y -q && apt-get -y -q autoclean && apt-get -y -q autoremove)
RUN apt-get install --no-install-recommends --no-install-suggests -y \
	apt-utils \
 	#apache2 \
	#php7.0 \
    	libapache2-mod-php7.0 \
	#php7.0-fpm \
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

#gitolite https://www.vultr.com/docs/setup-git-repositories-with-gitolite-on-debian-wheezy
#owncloud https://falstaff.agner.ch/2013/02/27/deploy-owncloud-from-source-using-git/
#let s encrytp https://www.digitalocean.com/community/tutorials/how-to-secure-apache-with-let-s-encrypt-on-debian-8

#COPY config/php.ini /usr/local/etc/php/
#COPY src/ /var/www/html/


RUN mkdir var/www/cherryclass/
RUN mkdir var/www/cherryclass/adminer/
RUN mkdir var/www/cherryclass/owncloud/
ADD index.php var/www/html

ADD adminer-4.3.1-mysql.php var/www/cherryclass/adminer/adminer.php
#ADD 000-default.conf /etc/hosts


#WARNING - not working on bluemix with bx ic run, need to put -p or create container with web console.
EXPOSE 80 443 110 143 145 22 25 53
