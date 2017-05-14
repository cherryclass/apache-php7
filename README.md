# Apache Php7-fpm    
## work with Wordpress, ssh , Mariadb , Bluemix        

[![N|Solid](http://cherryclass.net/img/php7.jpg )](http://php.net)
   
## Version
httpd 2.4  
php7.0-fpm  

Last : [1..0.0](https://github.com/cherryclass/apache-php7-fpm-ssh/blob/master/release.md)  

  


## Quick start
      
```
docker pull cherryclass/apache-php7-fpm-ssh
docker run -m 512 --name apache cherryclass/apache-php7-fpm-ssh
```
[![N|Solid](http://cherryclass.net/img/bluemix.jpg )](https://console.ng.bluemix.net) 
``` sh
#####Bluemix
docker pull cherryclass/apache-php7-fpm-ssh-bluemix
bx login -a https://api.ng.bluemix.net
bx ic init
bx ic namespace-get   

#### replace *namespace* by your's
docker tag cherryclass/apache-php7-fpm-ssh-bluemix:master registry.ng.bluemix.net/*namespace*/apache-php7-fpm-ssh:master 
docker push registry.ng.bluemix.net/*namespace*/apache-php7-fpm-ssh:master
   
#### set port in command line or start the container via web console, EXPOSE not work in DOKERFILE.
bx ic run -p 443 -p 80 p 22 --volume somevilumedata:/data/apache -m 256 --name apache registry.ng.bluemix.net/mynamespace/apache-php7-ssh
```    


## ssh - Filezilla
Access with bash command on your container
``` sh
### Bluemix
bx ic exec -it my_container bash
```
and set password for *www-data*, start ssh.
```  sh
$ sudo passwd www-data  
$ etc/init.d/ssh start
```

Start filezilla, putty etc with 
```  sh
yourip - www-data - yourpassword - 22
```    
Desinstall it on Dokerfile and default.conf if you want more security

[![N|Solid](http://cherryclass.net/img/logocherry180.png )](http://cherryclass.net)
