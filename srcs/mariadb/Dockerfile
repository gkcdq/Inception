FROM debian:bookworm
RUN apt-get update && apt-get install -y \
    mariadb-server \
    mariadb-client \
    && rm -rf /var/lib/apt/lists/*
# cree les fichiers necessaire et 'set' les permissions
RUN mkdir -p /run/mysqld /var/lib/mysql \
    && chown -R mysql:mysql /run/mysqld /var/lib/mysql
# initialise les data de MariaDB
RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql --auth-root-authentication-method=normal --skip-test-db
# Autorise les connections
RUN sed -i 's/127.0.0.1/0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf
# copy et commence le script d'entre
COPY ./mariadb.sh /usr/local/bin/mariadb.sh
RUN chmod +x /usr/local/bin/mariadb.sh

EXPOSE 3306
ENTRYPOINT ["/usr/local/bin/mariadb.sh"]
CMD ["/usr/bin/mysqld_safe", "--datadir=/var/lib/mysql"]
