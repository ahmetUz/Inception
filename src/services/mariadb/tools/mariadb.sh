#!/bin/bash

#démarrer MySQL
service mysql start;

#Ensuite il faut créer notre table !
mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"

#Je vais ensuite créer un utilisateur qui pourra la manipuler.
mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"

#Je donne tous les droits à cet utilisateur
mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"

#Je vais ensuite modifier mon utilisateur root 
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"

#Plus qu’à rafraichir tout cela
mysql -e "FLUSH PRIVILEGES;"

#shutdown
mysqladmin -u root -p $SQL_ROOT_PASSWORD shutdown

#execute service
exec mysqld_safe
