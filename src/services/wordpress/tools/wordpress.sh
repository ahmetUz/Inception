#!/bin/bash

#s'assurer que mariadb a eu le temps de charger
sleep 10

#cree le fichier wp-config.php pour la page wordpress
wp config create	--allow-root \
					--dbname=$SQL_DATABASE \
					--dbuser=$SQL_USER \
					--dbpass=$SQL_PASSWORD \
					--dbhost=mariadb:3306 --path='/var/www/wordpress'

#configurer la page automatiquement
wp core install --url=$DOMAIN_NAME --title=$SITE_TITLE --admin_user=$ADMIN_USER --admin_password=$ADMIN_PASSWORD --admin_email=$ADMIN_EMAIL --allow-root --path='/var/www/wordpress'

#ajouter un autre utilisateur
wp user create --allow-root --role=author $USER1_LOGIN $USER1_MAIL --user_pass=$USER1_PASS --path='/var/www/wordpress' >> log.txt

#cree le dossier php pour eviter une erreur
mkdir -p ./run/php

#lance php-fpm (pour utiliser le fastcgi process manager)
/usr/sbin/php-fpm7.3 -F
