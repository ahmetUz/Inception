FROM debian:buster

RUN apt-get -y update && apt-get -y upgrade && apt-get install -y mariadb-server

COPY conf/50-server.cnf	/etc/mysql/mariadb.conf.d/50-server.cnf

COPY tools/mariadb.sh /mariadb.sh

EXPOSE 3306

ENTRYPOINT ["bash", "mariadb.sh"]
