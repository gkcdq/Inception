# Utiliser l'image officielle MariaDB
FROM mariadb:latest

# Copier des fichiers de configuration personnalisés si nécessaire (facultatif)
# COPY ./my_custom_config.cnf /etc/mysql/conf.d/

# Variables d'environnement pour MariaDB (si elles ne sont pas déjà dans docker-compose)
# ENV MYSQL_ROOT_PASSWORD=rootpassword
# ENV MYSQL_DATABASE=wordpress
# ENV MYSQL_USER=wordpress_user
# ENV MYSQL_PASSWORD=wordpress_password

# Exposer le port 3306 pour la communication avec MariaDB
EXPOSE 3306

# Note: CMD ["mysqld"] n'est pas nécessaire si tu utilises l'image officielle MariaDB
# L'image officielle MariaDB gère déjà cela.

