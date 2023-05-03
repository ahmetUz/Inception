FROM debian:buster

#le apt update etc etc des familles + installation de wget pour telecharger wordpress
RUN apt-get -y update && apt-get -y upgrade && apt-get install -y wget

#pour ecouter sur le port 9000 comme demander dans le sujet
EXPOSE 9000

#installation des dependances requises (php && mariadb)
RUN apt-get install -y php7.3\
						php-fpm\
						php-mysql\
						mariadb-client

#installation de la page wordpress (compresser) dans le dossier /var/www
RUN wget https://fr.wordpress.org/wordpress-6.0-fr_FR.tar.gz -P /var/www


#decompresser le .tar.gz && le supprimer pck il nous sert plu a rien le reuf
RUN cd /var/www && tar -xzf wordpress-6.0-fr_FR.tar.gz && rm wordpress-6.0-fr_FR.tar.gz

#donner les droits a root d'ecrire dans le fichier
RUN chown -R root:root /var/www/wordpress

#installer le CLI (interface textuelle pour traiter les commandes)
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

# donner les droits a CLI et le mettre dans les binaires
RUN chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

#copier le .conf de la vm dans le docker
COPY    ./conf/www.conf    /etc/php/7.3/fpm/pool.d/www.conf
COPY	./tools/wordpress.sh wordpress.sh

ENTRYPOINT [ "bash", "wordpress.sh" ]