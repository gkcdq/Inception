FROM debian:bookworm
# Avoid interactive prompt
ENV DEBIAN_FRONTEND=noninteractive
# Instale PHP, MariaDB client, curl et CA certificates pour HTTPS
RUN apt-get update && apt-get install -y --no-install-recommends \
# php : Le langage de programmation lui-même
	php \
# php-fpm : (FastCGI Process Manager), NGINX ne sait pas lire le PHP tout seul donc il converti le php en php-fpm qui les exécute et renvoie le résultat à NGINX
	php-fpm \
# php-mysql : c'est le "pont" ou le driver qui permet à PHP de se connecter et de parler à ta base de données MariaDB
	php-mysql \
# php-curl : Une extension qui permet à WordPress de faire des requêtes HTTP (utile pour les API)
	php-curl \
# mariadb-client : Installe l'outil mysql en ligne de commande
	mariadb-client \
# curl : Un outil pour télécharger des fichiers
	curl \
# ca-certificates : Permet à ton conteneur de vérifier les certificats SSL lors de téléchargements sécurisés (HTTPS)
	ca-certificates \
	&& rm -rf /var/lib/apt/lists/*
# Cree les directory necessaire
RUN mkdir -p /run/php /var/www/html
# force l'ecoute sur le port 9000 de wordpress
RUN sed -i 's/^listen = .*$/listen = 0.0.0.0:9000/' /etc/php/8.2/fpm/pool.d/www.conf
# telecharge WP-CLI 
RUN curl -sSL https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -o /usr/local/bin/wp \
	&& chmod +x /usr/local/bin/wp
COPY ./wordpress.sh /usr/local/bin/wordpress.sh
RUN chmod +x /usr/local/bin/wordpress.sh
# Expose le port PHP-FPM 
EXPOSE 9000
# utilise le script comme point d'enttre
ENTRYPOINT ["/usr/local/bin/wordpress.sh"]
# lance PHP-FPM en arriere plan (-F)
CMD ["php-fpm8.2", "-F"]
