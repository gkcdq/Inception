FROM debian:bookworm

RUN apt-get update && apt-get install -y mariadb-server \
    && rm -rf /var/lib/apt/lists/*

COPY ./my.cnf /etc/mysql/my.cnf
COPY ./init.sql /docker-entrypoint-initdb.d/

VOLUME ["/var/lib/mysql"]

EXPOSE 3306

# Lancement de MariaDB en foreground pour Docker
CMD ["mysqld_safe", "--skip-networking=0", "--skip-grant-tables=0"]
