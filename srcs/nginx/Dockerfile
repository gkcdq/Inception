FROM debian:bookworm
# 1. Install NGINX and OpenSSL
RUN apt-get update && apt-get install -y \
    nginx \
    openssl \
    && rm -rf /var/lib/apt/lists/*
# 2. Generate a self-signed certificate for HTTPS
RUN mkdir -p /etc/ssl/certs /etc/ssl/private && \
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -subj "/C=FR/ST=Paris/O=42/CN=tmilin.42.fr" \
        -keyout /etc/ssl/private/nginx.key \
        -out /etc/ssl/certs/nginx.crt

# 3. Assurez-vous que Nginx peut lire ses fichiers
# Cette instruction est séparée et correcte
RUN chmod 777 /etc/ssl/private/nginx.key 

COPY ./nginx.conf /etc/nginx/nginx.conf
EXPOSE 443
# deamon off c'est pour lancer Nginx en arriere plan et -g c'est pour la configuration de type global (terminal)
CMD ["nginx", "-g", "daemon off;"]
