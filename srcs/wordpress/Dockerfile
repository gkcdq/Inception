# Utilise l'image officielle de WordPress
FROM wordpress:latest

# Installe les dépendances ou des plugins si nécessaire
# Par exemple, on peut ajouter des plugins ou thèmes :
# RUN curl -O https://downloads.wordpress.org/plugin/jetpack.latest-stable.zip && \
#     unzip jetpack.latest-stable.zip -d /var/www/html/wp-content/plugins/ && \
#     rm jetpack.latest-stable.zip

# Expose le port 80 (WordPress écoute sur le port 80)
EXPOSE 80

# Les variables d'environnement peuvent être définies directement ici ou dans le fichier docker-compose.yml
# ENV WORDPRESS_DB_HOST=mariadb:3306
# ENV WORDPRESS_DB_NAME=wordpress
# ENV WORDPRESS_DB_USER=wordpress_user
# ENV WORDPRESS_DB_PASSWORD=wordpress_password

# WordPress démarre automatiquement avec l'image officielle
CMD ["apache2-foreground"]
