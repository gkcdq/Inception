FROM debian:bookworm
# 1. Install NGINX et OpenSSL
RUN apt-get update && apt-get install -y \
    nginx \
    openssl \
    && rm -rf /var/lib/apt/lists/*
# 2. Genere un self-signed certificat pour HTTPS
RUN mkdir -p /etc/ssl/certs /etc/ssl/private && \
# openssl req (c'est loutil des demandes de certificat)
# -x509 (c'est le flag pour un certificat auto signe)
# -nodes (option pour que la cle ne soit pas proteger par un mdp pour que Nginx puisse redemarrer sans qu'un humain ait a taper un mdp)
# -days 365 (le nombre de jour ou le certificat sera valide)
# -newkey rsa:2048 (Génère en même temps une nouvelle clé privée utilisant l'algorithme RSA avec une taille de 2048 bits (le standard de sécurité actuel))
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
# -subj (ce flag permet de remplir automatiquement les informations du certificat sans que le terminal ne te pose de questions)
# -keyout (l'endroit où sera sauvegardée la clé privée (à garder secrète))
# -out (l'endroit où sera sauvegardé le certificat public (ce que le serveur envoie au navigateur pour prouver son identité))
        -subj "/C=FR/ST=Paris/O=42/CN=tmilin.42.fr" \
        -keyout /etc/ssl/private/nginx.key \
        -out /etc/ssl/certs/nginx.crt

# 3. Nginx doit avoir les droit pour lire ces fichiers 
RUN chmod 777 /etc/ssl/private/nginx.key 

COPY ./nginx.conf /etc/nginx/nginx.conf
EXPOSE 443
# deamon off c'est pour lancer Nginx en arriere plan et -g c'est pour la configuration de type global (terminal)
CMD ["nginx", "-g", "daemon off;"]
