CREATE DATABASE IF NOT EXISTS wordpress;

CREATE USER 'wpuser'@'%' IDENTIFIED BY 'wppassword';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wpuser'@'%';

CREATE USER 'secureadmin'@'%' IDENTIFIED BY 'secureadminpass';
GRANT ALL PRIVILEGES ON wordpress.* TO 'secureadmin'@'%';

FLUSH PRIVILEGES;
