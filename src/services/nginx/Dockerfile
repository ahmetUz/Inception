FROM debian:buster

RUN apt-get update && apt-get upgrade && apt-get install -y nginx
#update apt and install nginx

RUN mkdir -p /etc/nginx/ssl && apt-get install -y openssl
#create a folder to store the certificat and key in and install openssl to use ssl/tsl

RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=auzun.42.fr/UID=auzun"
#create the certificat and store the certificat and key

EXPOSE 443
# lisen on the 443 port

RUN mkdir -p /var/run/nginx
#create nginx conf folder

COPY conf/nginx.conf /etc/nginx/nginx.conf
#copy the vm conf file in docker conf folder

RUN mkdir -p /var/www/wordpress && chmod 755 /var/www/wordpress
#put the right acces for the root

RUN chown -R www-data:www-data /var/www/wordpress
#put the right acces for the user

CMD [ "nginx", "-g", "daemon off;" ]
#start nginx in fistground
