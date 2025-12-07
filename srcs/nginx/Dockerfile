# Utilise l'image officielle de Nginx
FROM nginx:latest

# Copie la configuration personnalisée de Nginx
COPY ./nginx.conf /etc/nginx/nginx.conf

# Copie les certificats SSL avec le chemin source CORRECT (directement depuis le contexte racine)
# COPY ./ssl-cert.pem /etc/ssl/certs/ssl-cert.pem
# COPY ./ssl-cert.key /etc/ssl/private/ssl-cert.key

# Expose les ports 80 et 443
EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]
