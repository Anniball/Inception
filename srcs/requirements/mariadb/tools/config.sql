--DELETE FROM mysql.user WHERE User='';
--DELETE FROM mysql.db WHERE Db='test';
--DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');

--SET PASSWORD FOR 'root'@'localhost' = PASSWORD('$MARIADB_ROOT_PASSWORD');
--Create user--
CREATE DATABASE '$MARIADB_DATABASE';
CREATE USER '$MARIADB_USER'@'%' IDENTIFIED by '$MARIADB_PASSWORD';
--Really not sure about that one--
GRANT ALL PRIVILEGES ON $MARIADB_DATABASE.* TO '$MARIADB_USER'@'%';

FLUSH PRIVILEGES;
