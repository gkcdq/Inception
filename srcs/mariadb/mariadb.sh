#!/bin/bash

# Initialise la data base si elle nexiste pas encore
if [ ! -d "/var/lib/mysql/$MYSQL_DATABASE" ]; then
    echo "[TMILIN] Initializing MariaDB database..."

    # Démarre MariaDB en arrière-plan pour l'initialisation
    /usr/bin/mysqld_safe --datadir=/var/lib/mysql &
    MYSQL_PID=$! # Enregistre l'ID du processus MariaDB

    # Vérification que MariaDB est en cours d'exécution
    until mysqladmin ping -uroot &>/dev/null; do
        echo "[TMILIN] Waiting for MariaDB to start..."
        sleep 1
    done

    # Exécution des commandes d'initialisation
    mysql -uroot <<MYSQL_SCRIPT
    CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
    ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';
    DELETE FROM mysql.user WHERE user='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
    DELETE FROM mysql.user WHERE user='';
    CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
    GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
    FLUSH PRIVILEGES;
MYSQL_SCRIPT
    echo "[TMILIN] Database initialization complete. Killing temporary process."
    
    # Tuer proprement le processus MariaDB démarré en arrière-plan
    kill -TERM $MYSQL_PID
    wait $MYSQL_PID # Attendre qu'il soit complètement arrêté pour éviter la corruption
fi

# Démarrer MariaDB correctement en mode foreground (PID 1)
exec "$@"