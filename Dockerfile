FROM httpd:2.4

MAINTAINER Luc Frébourg

ENV DEBIAN_FRONTEND noninteractive

#install stuff
RUN (apt-get update && apt-get upgrade -y -q && apt-get dist-upgrade -y -q && apt-get -y -q autoclean && apt-get -y -q autoremove)
RUN apt-get install --no-install-recommends --no-install-suggests -y \
	aptitude \
    	apt-utils
 RUN aptitude install -y\
	php7.0-fpm \
    	php-mysql \
	php-xml \
	php7.0-mbstring \
	phpmyadmin 

#GIT ---------------
RUN aptitude install -y\
	gitolite3 \
	gitweb

#SSH ------------------------------
RUN aptitude install -y\
	sudo \
   	ssh 
	
RUN mkdir /home/site
RUN mkdir /home/site/www
ADD index.php /home/site/www/index.php
RUN chown -R www-data:www-data /home/site/www
RUN chsh -s /bin/bash www-data

#CONFIG ----------------------
#PHP
#ADD php.ini /etc/php/7.0/fpm/php.ini



#start services
CMD service php7.0-fpm start && httpd -g "daemon off;"

#WARNING - not working on bluemix with bx ic run, need to put -p or create container with web console.
EXPOSE 80 443 110 143 145 22 25 53
