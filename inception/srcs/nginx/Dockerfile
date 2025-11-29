FROM debian:bookworm

RUN apt-get update && apt-get install -y nginx openssl \
    && rm -rf /var/lib/apt/lists/*

COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./cert.pem /etc/ssl/certs/cert.pem
COPY ./key.pem /etc/ssl/private/key.pem

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
